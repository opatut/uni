import java.util.Random;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;

import javax.swing.JFrame;
import javax.swing.JPanel;

/**
 * Diese Implementation des Interfaces InPlaceSortierbareIntListe stellt den
 * Zustand einer Liste von int-Werten grafisch dar. Auf der x-Achse ist die
 * Position in der Liste, auf der y-Achse der jeweilige int-Wert aufgetragen.
 * Unten links ist die Position 0/0.
 * 
 * Die VisualIntListe bietet Konstruktoren, die eine neue VisualIntListe
 * unsortiert mit Werten fuellen. Mit entsprechenden Konstruktorparametern kann
 * die grafische Darstellung konfiguriert werden.
 * 
 * @author Petra Becker-Pechau
 * @author Lars-Peter Clausen
 * @author Julian Fietkau
 * @author Fredrik Winkler
 * @author Axel Schmolitzky
 * @version September 2011
 */
final class VisualIntListe implements InPlaceSortierbareIntListe
{
    /**
     * Enthaelt die zu sortierenden Werte.
     */
    private final int[] _wert;
    
    /**
     * Enthaelt eine konstante Verzoegerung fuer die grafische Aktualisierung.
     * Die Verzoegerung wird einmalig im Konstruktor abhaengig von der 
     * Listenlaenge berechnet.
     */
    private final int _verzoegerung;

    /**
     * Enthaelt das Anzeigepanel
     */
    private final PunktePanel _panel;

    /**
     * Erzeugt eine neue VisualIntListe der Groesse 100 und fuellt sie
     * unsortiert mit den Werten von 0 bis laenge-1.
     */
    public VisualIntListe()
    {
        this(100);
    }

    /**
     * Erzeugt eine neue VisualIntListe und fuellt sie unsortiert mit den Werten
     * von 0 bis laenge-1. 
     * 
     * Die Verzoegerung und die Punktgroesse werden abhaengig von der gegebenen 
     * Laenge berechnet.
     *  
     * @param laenge
     *            die Laenge (Kardinalitaet) der zu erzeugenden Liste. 
     */
    public VisualIntListe(int laenge)
    {
        // Die Verzoegerung wird groesser, wenn die Liste kleiner ist (quadratisch)
        // Die Punkt-Groesse ist mindestens 1, ansonsten 400/laenge
        this(laenge, (int) (Math.pow(7-(Math.min(laenge,108.0)/18),2)), Math.max(400 / laenge, 1));
    }

    /**
     * Erzeugt eine neue VisualIntListe und fuellt sie unsortiert mit den Werten
     * von 0 bis laenge-1.
     * 
     * @param laenge
     *            die Laenge (Kardinalitaet) der zu erzeugenden Liste
     * @param verzoegerung
     *            die Verzoegerung in ms
     * @param punktGroesse
     *            jeder int-Wert wird durch entsprechend viele Pixel dargestellt
     */
    public VisualIntListe(int laenge, int verzoegerung, int punktGroesse)
    {
        _wert = new int[laenge];
        for (int i = 0; i < laenge; ++i)
        {
            _wert[i] = i;
        }
        _verzoegerung = verzoegerung;
        _panel = new PunktePanel(_wert, punktGroesse);
        initialisiereGemischt();
    }

    /**
     * Vertauscht die Elemente an den Positionen i und k.
     * 
     * @param i Erste Positionsangabe eines zu vertauschenden Elements.
     * @param k Zweite Positionsangabe eines zu vertauschenden Elements.
     */
    private void swap(int i, int k)
    {
        int temp = _wert[i];
        _wert[i] = _wert[k];
        _wert[k] = temp;
    }

    /**
     * Gib die Anzahl der Werte in der Liste zurueck.
     * 
     * @return die Anzahl der Werte in der Liste
     */
    public int gibLaenge()
    {
        return _wert.length;
    }

    /**
     * Pruefe, ob sich in der Liste an der angegebenen Position ein int-Wert
     * befindet.
     * 
     * @param position
     *            die zu pruefende Position
     * @return true, falls (position >= 0) && (position < gibLaenge())
     */
    public boolean existiert(int position)
    {
        return (position >= 0) && (position < gibLaenge());
    }

    private void pruefe(int position)
    {
        if (!existiert(position))
        {
            throw new IndexOutOfBoundsException(String.valueOf(position));
        }
    }
    
    /**
     * Gib den Wert an der angegebenen Position zurueck.
     * 
     * @param position
     *            die Position des int-Werts, der zurueckgegeben werden soll
     * @throws IndexOutOfBoundsException
     *             falls !existiert(position)
     * @return der Wert an der angegebenen Position
     */
    public int gib(int position)
    {
        pruefe(position);

        _panel.selectPoint(position);
        zeichne(position);
        _panel.deselectPoint();
        _panel.zeichnePosition(position);
        return _wert[position];
    }

    /**
     * Vertausche die beiden Elemente an den angegebenen Positionen in der
     * Liste.
     * 
     * @param i
     *            die Position des ersten Elements
     * @param k
     *            die Position des zweiten Elements
     * @throws IndexOutOfBoundsException
     *             falls !(existiert(i) && existiert(k))
     */
    public void vertausche(int i, int k)
    {
        pruefe(i);
        pruefe(k);

        swap(i, k);

        zeichne(i);
        zeichne(k);
    }

    /**
     * "Sortiert" die Liste aufsteigend, indem einfach jeder Index mit dem
     * passenden Wert 0..Laenge-1 ueberschrieben wird.
     */
    public void initialisiereAufsteigend()
    {
        int sup = gibLaenge();
        for (int i = 0; i < sup; ++i)
        {
            _wert[i] = i;
        }
        _panel.repaint();
    }

    /**
     * "Sortiert" die Liste absteigend, indem einfach jeder Index mit dem
     * passenden Wert Laenge-1..0 ueberschrieben wird.
     */
    public void initialisiereAbsteigend()
    {
        int sup = gibLaenge();
        for (int i = 0; i < sup; ++i)
        {
            _wert[i] = sup - 1 - i;
        }
        _panel.repaint();
    }

    /**
     * Sortiert die Liste so, dass ihre Eintraege tendenziell zwischen hohen und
     * niedrigen Werten hin und her springen.
     */
    public void initialisiereAlternierend()
    {
        int sup = gibLaenge();
        for (int i = 0; i < sup; i += 2)
        {
            _wert[i] = i;
        }
        for (int i = 1, k = (sup | 1) - 2; i < sup; i += 2, k -= 2)
        {
            _wert[i] = k;
        }
        _panel.repaint();
    }

    /**
     * Permutiert die aktuelle Liste so, dass die Eintraege zufaellig angeordnet
     * sind. Die Liste sieht nach jedem Aufruf anders aus.
     */
    public void initialisiereGemischt()
    {
        Random zufall = new Random();
        for (int i = gibLaenge() - 1; i > 0; --i)
        {
            swap(i, zufall.nextInt(i));
        }
        _panel.repaint();
    }

    /**
     * Zeichnet die gegebene Position neu und wartet kurz
     */
    private void zeichne(int position)
    {
        _panel.zeichnePosition(position);
        try
        {
            Thread.sleep(_verzoegerung);
        }
        catch (InterruptedException e)
        {
            e.printStackTrace();
        }
    }

    /**
     * Dieses Panel dient zur Darstellung eines int-Arrays in einem
     * Koordinatensystem.
     * 
     * Auf der X-Achse werden die Indizes aufgetragen, auf der Y-Achse die
     * Werte. Es wird davon ausgegangen, dass das Array die Werte von 0 bis
     * laenge-1 enthaelt. Fuer das Setzen eines Wertes wird eine zusaetzliche
     * zeichne-Methode angeboten, um die Performanz zu erhoehen.
     */
    private static class PunktePanel extends JPanel
    {
        private static final Color BACKGROUND_COLOR = Color.BLACK;
        private static final Color POINT_COLOR = Color.WHITE;
        private static final Color SELECTED_POINT_COLOR = Color.RED;
        private static final Color FINAL_POINT_COLOR = Color.GREEN;
        private static final int RAND = 4;

        private final int[] _intArray;
        private final int _punktGroesse;
        private final int _ausdehnung;
        private int _selected;

        private final JFrame _frame;

        /**
         * Erzeugt ein neues PunktePanel.
         * 
         * @param intArray Die anzuzeigenden Werte.
         * @param punktGroesse Pixelanzahl, die zur Anzeige eines Punktes genutzt werden.
         */
        public PunktePanel(int[] intArray, int punktGroesse)
        {
            _intArray = intArray;
            _punktGroesse = punktGroesse;
            _ausdehnung = intArray.length * punktGroesse;
            _selected = -1;

            // Initialisere dieses Panel
            setBackground(BACKGROUND_COLOR);
            int groesse = RAND + _ausdehnung + RAND;
            setPreferredSize(new Dimension(groesse, groesse));

            // Initialisiere das verwendete JFrame und setze dich selbst (Panel-Objekt) als content pane.
            _frame = new JFrame(VisualIntListe.class.getName());
            _frame.setResizable(false);
            _frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            _frame.getContentPane().add(this);
            _frame.setBackground(BACKGROUND_COLOR);
            _frame.pack();
            _frame.setVisible(true);
        }

        /**
         * Gib die Pixelkoordinate fue die uebergebene Position zurueck.
         * 
         * @param position Eine Position deren Pixelkoordinate zurueckgegeben werden soll.
         * @return eine Pixelkoordinate fue die uebergebene Position zurueck.
         */
        private int screenAt(int position)
        {
            return RAND + position * _punktGroesse;
        }

        /**
         * Zeichnet einen Punkt mit der entsprechenden Punktgroesse auf den Bildschirm.
         * 
         * @param x x-Koordinate des Punkts
         * @param y y-Koordinate des Punkts
         * @param color Die zu verwendende Farbe
         * @param g Ein zu verwendendes Graphics-Objekt auf dem gezeichnet werden soll
         */
        private void zeichnePunkt(int x, int y, Color color, Graphics g)
        {
            y = _intArray.length - 1 - y;
            g.setColor(color);
            g.fillRect(screenAt(x), screenAt(y), _punktGroesse, _punktGroesse);
        }

        /**
         * Zeichnet die angegebene Position.
         * @param x Eine Position
         */
        public void zeichnePosition(int x)
        {
            repaint(screenAt(x), RAND, _punktGroesse, _ausdehnung);
        }

        /**
         * Zeichnet das Panel.
         * @param g Ein Graphics-Objekt auf dem gezeichnet werden soll.
         */
        public void paint(Graphics g)
        {
            super.paint(g);
            for (int i = 0; i < _intArray.length; ++i)
            {
                Color color = POINT_COLOR;
                if (i == _selected)
                {
                    color = SELECTED_POINT_COLOR;
                }
                else if (i == _intArray[i])
                {
                    color = FINAL_POINT_COLOR;
                }
                zeichnePunkt(i, _intArray[i], color, g);
            }
        }

        /**
         * Selektiert eine Position, so dass diese hervorgehoben gezeichnet wird.
         * 
         * @param position Eine Position, die selektiert werden soll.
         */
        public void selectPoint(int position)
        {
            _selected = position;
        }

        /**
         * Deselktiert die augenblicklich selektierte Position.
         */
        public void deselectPoint()
        {
            _selected = -1;
        }

        private static final long serialVersionUID = -1621544717859097232L;
    }
}
