/**
 * In dieser Klasse ist die Spiellogik von "Vier gewinnt" realisiert.
 * 
 * Zwei Spieler legen abwechselnd einen Spielstein in einer freien Spalte ab, bis ein Spieler vier
 * Steine in einer Reihe hat oder das Spielfeld voll ist.
 * 
 * @author Fredrik Winkler
 * @version 4. Januar 2007
 */
class VierGewinnt
{
    private final Spielfeld _spielfeld;
    private final SpielfeldAnalyse _analyse;

    private int _spieler;
    private boolean _spielZuEnde;

    /**
     * Erzeugt ein neues Vier-Gewinnt-Spiel mit einem leeren Spielfeld. Spieler 1 ist als erster
     * dran, und das Spiel ist noch nicht zu Ende.
     */
    public VierGewinnt()
    {
        _spielfeld = new SpielfeldArray();
        _analyse = new SpielfeldAnalyse(_spielfeld);

        _spieler = 1;
        _spielZuEnde = false;
    }

    /**
     * Gibt an, welcher Spieler gerade dran ist oder gewonnen hat.
     * 
     * @return 1 (Spieler 1) oder 2 (Spieler 2) oder 0 (Spiel ist unentschieden ausgegangen)
     */
    public int gibAktuellenSpieler()
    {
        return _spieler;
    }

    /**
     * Wechselt den aktuellen Spieler von 1 zu 2 und umgekehrt.
     */
    private void wechsleSpieler()
    {
        _spieler = 3 - _spieler;
    }

    /**
     * Gibt an, ob das Spiel zu Ende ist. Falls es zu Ende ist, liefert gibAktuellenSpieler() den
     * Gewinner.
     */
    public boolean istSpielZuEnde()
    {
        return _spielZuEnde;
    }

    /**
     * Gibt die letzte gefundene Vierer-Kombination.
     */
    public Kombination gibVierer()
    {
        return _analyse.gibVierer();
    }

    /**
     * Gibt den Besitzer der angegebenen Position auf dem Spielfeld.
     * 
     * @param zeile
     *            vertikale Position
     * @param spalte
     *            horizontale Position
     * @return 0 (unbesetzt), 1 (Spieler 1), 2 (Spieler 2)
     */
    public int gibBesitzer(int zeile, int spalte)
    {
        return _spielfeld.gibBesitzer(zeile, spalte);
    }

    /**
     * Ist die angegebene Spalte voll?
     */
    public boolean istSpalteVoll(int spalte)
    {
        return _spielfeld.istSpalteVoll(spalte);
    }

    /**
     * Legt einen Spielstein in einer Spalte ab. Anschliessend wird geprueft, ob der aktuelle
     * Spieler gewonnen hat, oder ob das Spielfeld voll ist. Ansonsten wird der aktuelle Spieler
     * gewechselt.
     * 
     * @param spalte
     *            horizontale Position
     */
    public void legeSpielsteinAb(int spalte)
    {
        if (!istSpielZuEnde() && !istSpalteVoll(spalte))
        {
            _spielfeld.legeSpielsteinAb(spalte, _spieler);

            if (_analyse.hatSpielerGewonnen(_spieler))
            {
                _spielZuEnde = true;
            }
            else if (_spielfeld.istSpielfeldVoll())
            {
                _spielZuEnde = true;
                _spieler = 0;
            }
            else
            {
                wechsleSpieler();
            }
        }
    }
}
