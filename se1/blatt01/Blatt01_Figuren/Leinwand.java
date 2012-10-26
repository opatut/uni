import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.Shape;
import java.awt.event.ComponentAdapter;
import java.awt.event.ComponentEvent;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.swing.JFrame;
import javax.swing.JPanel;

/**
 * Leinwand ist eine Klasse, die einfache Zeichenoperationen auf einer
 * leinwandartigen Zeichenflaeche ermoeglicht. Sie ist eine vereinfachte Version
 * der Klasse Canvas (englisch fuer Leinwand) des JDK und wurde speziell fuer
 * das Projekt "Figuren" geschrieben.
 * 
 * @author: Bruce Quig
 * @author: Michael Kolling (mik)
 * @author: Axel Schmolitzky
 * @author: Fredrik Winkler
 * 
 * @version: 2.2
 */
public class Leinwand extends JPanel
{
    private static final Leinwand leinwand;
    private static final Map<String, Color> farben;

    static
    {
        leinwand = new Leinwand("Leinwand", 400, 300, Color.white);

        farben = new HashMap<String, Color>();
        farben.put("rot", Color.red);
        farben.put("blau", Color.blue);
        farben.put("gelb", Color.yellow);
        farben.put("gruen", Color.green);
        farben.put("lila", Color.magenta);
        farben.put("weiss", Color.white);
    }

    /**
     * Liefert eine Referenz auf das einzige Exemplar dieser Klasse.
     * 
     * @return Leinwand
     */
    public static Leinwand gibLeinwand()
    {
        return leinwand;
    }

    private final Map<Object, ShapeMitFarbe> figuren;

    private final JFrame frame;
    private final Color hintergrundfarbe;
    private Image image;
    private Graphics2D graphics;

    /**
     * Erzeuge eine Leinwand.
     * 
     * @param titel
     *            Titel, der im Rahmen der Leinwand angezeigt wird
     * @param breite
     *            die gewuenschte Breite der Leinwand
     * @param hoehe
     *            die gewuenschte Hoehe der Leinwand
     * @param grundfarbe
     *            die Hintergrundfarbe der Leinwand
     */
    private Leinwand(String titel, int breite, int hoehe, Color grundfarbe)
    {
        figuren = new LinkedHashMap<Object, ShapeMitFarbe>();

        frame = new JFrame();
        frame.setContentPane(this);
        frame.setTitle(titel);
        setPreferredSize(new Dimension(breite, hoehe));
        frame.pack();
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        hintergrundfarbe = grundfarbe;
        calculateGraphics();
        setzeSichtbarkeit(true);

        addComponentListener(new ComponentAdapter()
        {
            public void componentResized(ComponentEvent evt)
            {
                neuZeichnen();
            }
        });
    }

    private void calculateGraphics()
    {
        Dimension size = getSize();
        image = createImage(size.width, size.height);

        graphics = (Graphics2D) image.getGraphics();
        graphics.setColor(hintergrundfarbe);
        graphics.fillRect(0, 0, size.width, size.height);
    }

    private void neuZeichnen()
    {
        calculateGraphics();

        synchronized (figuren)
        {
            for (ShapeMitFarbe shape: figuren.values())
                shape.draw(graphics);
        }

        repaint();
    }

    public void paint(Graphics g)
    {
        g.drawImage(image, 0, 0, null);
    }

    /**
     * Setze, ob diese Leinwand sichtbar sein soll oder nicht. Wenn die Leinwand
     * sichtbar gemacht wird, wird ihr Fenster in den Vordergrund geholt. Diese
     * Operation kann auch benutzt werden, um ein bereits sichtbares
     * Leinwandfenster in den Vordergrund (vor andere Fenster) zu holen.
     * 
     * @param sichtbar
     *            boolean fuer die gewuenschte Sichtbarkeit: true fuer sichtbar,
     *            false fuer nicht sichtbar.
     */
    public void setzeSichtbarkeit(boolean sichtbar)
    {
        frame.setVisible(sichtbar);
    }

    /**
     * Zeichne fuer das gegebene Figur-Objekt eine Java-Figur (einen Shape) auf
     * die Leinwand.
     * 
     * @param figur
     *            das Figur-Objekt, fuer das ein Shape gezeichnet werden soll
     * @param farbe
     *            die Farbe der Figur
     * @param shape
     *            ein Objekt der Klasse Shape, das tatsaechlich gezeichnet wird
     */
    public void zeichne(Object figur, String farbe, Shape shape)
    {
        ShapeMitFarbe shapeMitFarbe = new ShapeMitFarbe(shape, farbe);
        
        boolean geloescht;
        synchronized (figuren)
        {
            if (geloescht = figuren.containsKey(figur))
            {
                figuren.remove(figur);
            }
            figuren.put(figur, shapeMitFarbe);
        }
        
        if (geloescht)
        {
            neuZeichnen();
        }
        else
        {
            shapeMitFarbe.draw(graphics);
            repaint(shape.getBounds());
        }
    }

    /**
     * Entferne die gegebene Figur von der Leinwand.
     * 
     * @param figur
     *            die Figur, deren Shape entfernt werden soll
     */
    public void entferne(Object figur)
    {
        synchronized (figuren)
        {
            figuren.remove(figur);
        }
        neuZeichnen();
    }

    /**
     * Setze die Zeichenfarbe der Leinwand.
     * 
     * @param farbname
     *            der Name der neuen Zeichenfarbe.
     */
    public void setzeZeichenfarbe(String farbname)
    {
        Color farbe = farben.get(farbname);
        graphics.setColor(farbe != null ? farbe : Color.black);
    }

    /**
     * Warte fuer die angegebenen Millisekunden. Mit dieser Operation wird eine
     * Verzoegerung definiert, die fuer animierte Zeichnungen benutzt werden
     * kann.
     * 
     * @param millisekunden
     *            die zu wartenden Millisekunden
     */
    public void warte(int millisekunden)
    {
        try
        {
            Thread.sleep(millisekunden);
        }
        catch (Exception e)
        {
            // Exception ignorieren
        }
    }

    /**
     * Interne Klasse ShapeMitFarbe - Da die Klasse Shape des JDK nicht auch
     * eine Farbe mitverwalten kann, muss mit dieser Klasse die Verknuepfung
     * modelliert werden.
     */
    private class ShapeMitFarbe
    {
        private Shape shape;
        private String farbe;

        public ShapeMitFarbe(Shape shape, String farbe)
        {
            this.shape = shape;
            this.farbe = farbe;
        }

        public void draw(Graphics2D graphic)
        {
            setzeZeichenfarbe(farbe);
            graphic.fill(shape);
        }
    }
}
