import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * Analyse von Spielsituationen auf einem Spielfeld.
 * 
 * @author Fredrik Winkler
 * @version 17. Dezember 2012
 */
class SpielfeldAnalyse
{
    private final Spielfeld _spielfeld;
    private Kombination _vierer;

    /**
     * Erstellt eine neue SpielfeldAnalyse.
     * 
     * @param spielfeld
     *            das Spielfeld, das analysiert werden soll
     */
    public SpielfeldAnalyse(Spielfeld spielfeld)
    {
        _spielfeld = spielfeld;
    }

    /**
     * Ueberprueft, ob ein Spieler gewonnen hat.
     */
    public boolean hatSpielerGewonnen(int spieler)
    {
        pruefeVierer(spieler);
        return _vierer != null;
    }

    /**
     * Gibt die letzte gefundene Vierer-Kombination.
     */
    public Kombination gibVierer()
    {
        return _vierer;
    }

    private void pruefeVierer(int spieler)
    {
        pruefeVierer(spieler, 0, 0, 5, 3, 0, 1);
        pruefeVierer(spieler, 0, 0, 2, 6, 1, 0);
        pruefeVierer(spieler, 0, 0, 2, 3, 1, 1);
        pruefeVierer(spieler, 0, 3, 2, 6, 1, -1);
    }

    private void pruefeVierer(int spieler, int zeile, int spalte, int zeile2, int spalte2, int dZeile, int dSpalte)
    {
        for (int z = zeile; z <= zeile2; ++z)
        {
            for (int s = spalte; s <= spalte2; ++s)
            {
                pruefeVierer(spieler, z, s, dZeile, dSpalte);
            }
        }
    }

    private void pruefeVierer(int spieler, int zeile, int spalte, int dZeile, int dSpalte)
    {
        if (_spielfeld.gibBesitzer(zeile + 0 * dZeile, spalte + 0 * dSpalte) == spieler
         && _spielfeld.gibBesitzer(zeile + 1 * dZeile, spalte + 1 * dSpalte) == spieler
         && _spielfeld.gibBesitzer(zeile + 2 * dZeile, spalte + 2 * dSpalte) == spieler
         && _spielfeld.gibBesitzer(zeile + 3 * dZeile, spalte + 3 * dSpalte) == spieler)
        {
            _vierer = new Kombination(zeile, spalte, dZeile, dSpalte);
        }
    }
}

/**
 * Werttyp, der eine beliebige Kombination auf dem Spielfeld speichert.
 * 
 * @author Fredrik Winkler
 * @version 17. Dezember 2012
 */
class Kombination
{
    public final int zeile, spalte, dZeile, dSpalte;

    /**
     * Erzeugt eine neue Kombination.
     * 
     * @param zeile
     *            Startposition
     * @param spalte
     *            Startposition
     * @param dZeile
     *            Richtung
     * @param dSpalte
     *            Richtung
     */
    public Kombination(int zeile, int spalte, int dZeile, int dSpalte)
    {
        this.zeile = zeile;
        this.spalte = spalte;
        this.dZeile = dZeile;
        this.dSpalte = dSpalte;
    }
    
    public boolean equals(Object other)
    {
        return (other instanceof Kombination) && equals((Kombination)other);
    }
    
    public boolean equals(Kombination other)
    {
        return zeile == other.zeile
            && spalte == other.spalte
            && dZeile == other.dZeile
            && dSpalte == other.dSpalte;
    }
    
    public int hashCode()
    {
        return ((zeile * 31 + spalte) * 31 + dZeile) * 31 + dSpalte;
    }
}
