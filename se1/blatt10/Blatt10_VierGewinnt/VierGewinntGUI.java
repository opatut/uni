import java.awt.Color;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.lang.reflect.InvocationTargetException;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.SwingUtilities;

/**
 * Klasse nicht zum Aneignen von OO-Konzepten gedacht, da hier fuer
 * die Uebersichtlichkeit des Gesamtprojekts aller UI-Code vereinigt ist.
 * 
 * Deswegen nicht kommentiert.
 * 
 * @author Fredrik Winkler
 * @version 17. Dezember 2012
 */
class VierGewinntGUI extends JFrame
{
    private VierGewinnt spiel;
    private SpielfeldGUI spielfeld;

    private volatile boolean animation;

    public VierGewinntGUI()
    {
        super("Vier gewinnt");

        SwingUtilities.invokeLater(new Runnable()
        {
            public void run()
            {
                setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
                setSize(700, 600);
                setVisible(true);
                setAlwaysOnTop(true);
                neuesSpiel();
            }
        });
    }

    private void neuesSpiel()
    {
        spiel = new VierGewinnt();
        if (spielfeld != null) remove(spielfeld);
        spielfeld = new SpielfeldGUI();
        add(spielfeld);
        validate();
    }

    private class SpielfeldGUI extends JPanel
    {
        public SpielfeldGUI()
        {
            setLayout(new GridLayout(Spielfeld.HOEHE, Spielfeld.BREITE));
            final Font font = new Font("Webdings", Font.PLAIN, 36);
            for (int y = 0; y < Spielfeld.HOEHE; ++y)
            {
                for (int x = 0; x < Spielfeld.BREITE; ++x)
                {
                    final JButton button = new JButton("\uf06e");
                    button.setFont(font);
                    button.setBackground(FARBE[0]);
                    button.setForeground(FARBE[0]);
                    button.addActionListener(new ButtonListener(x));
                    add(button);
                }
            }
        }

        private JButton getButton(int y, int x)
        {
            y = Spielfeld.HOEHE - 1 - y;
            return (JButton) getComponent(Spielfeld.BREITE * y + x);
        }
        
        public void refresh(VierGewinnt spiel)
        {
            for (int y = 0; y < Spielfeld.HOEHE; ++y)
            {
                for (int x = 0; x < Spielfeld.BREITE; ++x)
                {
                    getButton(y, x).setForeground(FARBE[(spiel.gibBesitzer(y, x))]);
                }
            }
        }

        public void faerbeEin(Kombination vierer, Color farbe)
        {
            for (int i = 0; i < 4; ++i)
            {
                int z = vierer.zeile + i * vierer.dZeile;
                int s = vierer.spalte + i * vierer.dSpalte;
                getButton(z, s).setForeground(farbe);
            }
        }

        public void buttonListener(ActionListener listener)
        {
            for (int y = 0; y < Spielfeld.HOEHE; ++y)
            {
                for (int x = 0; x < Spielfeld.BREITE; ++x)
                {
                    JButton button = getButton(y, x);
                    for (ActionListener al : button.getActionListeners())
                    {
                        button.removeActionListener(al);
                    }
                    button.addActionListener(listener);
                }
            }
        }
    }

    private class ButtonListener implements ActionListener
    {
        private final int spalte;

        public ButtonListener(int spalte)
        {
            this.spalte = spalte;
        }

        public void actionPerformed(ActionEvent e)
        {
            if (!spiel.istSpalteVoll(spalte))
            {
                spiel.legeSpielsteinAb(spalte);
                spielfeld.refresh(spiel);
                SwingUtilities.invokeLater(new Runnable()
                {
                    public void run()
                    {
                        if (spiel.istSpielZuEnde())
                        {
                            if (spiel.gibAktuellenSpieler() == 0)
                            {
                                spielfeld.buttonListener(new ActionListener()
                                {
                                    public void actionPerformed(ActionEvent e)
                                    {
                                        neuesSpiel();
                                    }
                                });
                            }
                            else
                            {
                                animation = true;
                                spielfeld.buttonListener(new ActionListener()
                                {
                                    public void actionPerformed(ActionEvent e)
                                    {
                                        animation = false;
                                    }
                                });
                                new Thread(new GewinnAnimierer(spiel.gibVierer(), FARBE[spiel
                                        .gibAktuellenSpieler()])).start();
                            }
                        }
                    }
                });
            }
            else
            {
                JOptionPane.showMessageDialog(spielfeld, BELEGT, "Spalte voll",
                        JOptionPane.ERROR_MESSAGE);
            }
        }
    }

    private class GewinnAnimierer implements Runnable
    {
        private final Kombination vierer;
        private final Color gewinner;
        private boolean step;

        public GewinnAnimierer(Kombination vierer, Color gewinner)
        {
            this.vierer = vierer;
            this.gewinner = gewinner;
        }

        public void run()
        {
            while (animation)
            {
                try
                {
                    SwingUtilities.invokeAndWait(new Runnable()
                    {
                        public void run()
                        {
                            spielfeld.faerbeEin(vierer, step ? FARBE[0] : gewinner);
                        }
                    });
                    step = !step;
                    Thread.sleep(500);
                }
                catch (InterruptedException e)
                {
                    e.printStackTrace();
                }
                catch (InvocationTargetException e)
                {
                    e.printStackTrace();
                }
            }
            neuesSpiel();
        }
    }

    private static Color[] FARBE = { Color.LIGHT_GRAY, Color.YELLOW, Color.RED };

    private static final String BELEGT = "Diese Spalte ist voll. Bitte eine andere waehlen!";
}
