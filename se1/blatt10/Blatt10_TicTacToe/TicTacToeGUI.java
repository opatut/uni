import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;

/**
 * @author Fredrik Winkler
 * @version 26.11.07
 */
class TicTacToeGUI extends JFrame
{
    private TicTacToe game;
    private final JPanel rows;
    private final JLabel label;
    private final JPanel panel;

    public TicTacToeGUI()
    {
        super("Tic Tac Toe");
        game = new TicTacToe();

        rows = new JPanel();
        rows.setLayout(new BoxLayout(rows, BoxLayout.Y_AXIS));

        final Font font = new Font("Monospaced", Font.PLAIN, 36);
        for (int y = 0; y < 3; ++y)
        {
            final JPanel row = new JPanel();
            row.setLayout(new BoxLayout(row, BoxLayout.X_AXIS));
            for (int x = 0; x < 3; ++x)
            {
                final JButton button = new JButton();
                button.setFont(font);
                button.addActionListener(new ButtonListener(y, x));
                row.add(button);
            }
            rows.add(row);
        }

        label = new JLabel();
        label.setFont(new Font("SansSerif", Font.PLAIN, 24));

        panel = new JPanel();
        panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));

        rows.setAlignmentX(0.5f);
        label.setAlignmentX(0.5f);
        panel.add(rows);
        panel.add(label);
        add(panel);

        refresh();

        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(256, 256);
        setVisible(true);
        setAlwaysOnTop(true);
    }

    private void refreshPlayfield()
    {
        for (int y = 0; y < 3; ++y)
        {
            final JPanel row = (JPanel) (rows.getComponent(y));
            for (int x = 0; x < 3; ++x)
            {
                final JButton button = (JButton) (row.getComponent(x));
                button.setText(BESCHRIFTUNG[(game.gibBesitzer(y, x))]);
            }
        }
    }

    private void refreshLabel()
    {
        label.setText(SPIELER[game.gibAktuellenSpieler()]);
    }

    private void refresh()
    {
        refreshPlayfield();
        refreshLabel();
    }

    private class ButtonListener implements ActionListener
    {
        private final int zeile, spalte;

        public ButtonListener(int zeile, int spalte)
        {
            this.zeile = zeile;
            this.spalte = spalte;
        }

        public void actionPerformed(ActionEvent e)
        {
            if (game.istFrei(zeile, spalte))
            {
                game.besetzePosition(zeile, spalte);
                refreshPlayfield();

                if (game.istSpielZuEnde())
                {
                    JOptionPane.showMessageDialog(rows, String.format(GEWONNEN, SPIELER[game
                            .gibAktuellenSpieler()]), "Spielende", JOptionPane.INFORMATION_MESSAGE);
                    game = new TicTacToe();
                    refresh();
                }
                else
                {
                    refreshLabel();
                }
            }
            else
            {
                JOptionPane.showMessageDialog(rows, BELEGT, "Position belegt",
                        JOptionPane.ERROR_MESSAGE);
            }
        }
    }

    private static final String[] BESCHRIFTUNG = { " ", "X", "O" };
    private static final String[] SPIELER = { "Keiner", "Spieler 1 (X)", "Spieler 2 (O)" };

    private static final String GEWONNEN = "%s hat gewonnen. OK druecken fuer ein weiteres Spiel!";
    private static final String BELEGT = "Diese Position ist bereits belegt. Bitte eine andere waehlen!";

    private static final long serialVersionUID = -6075446865601504292L;
}
