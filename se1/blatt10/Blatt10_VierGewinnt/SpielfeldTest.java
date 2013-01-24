/**
 * Testklasse zur Klasse SpielfeldArray.
 *
 * @author Fredrik Winkler
 * @version 20. Dezember 2011
 */
public class SpielfeldTest extends junit.framework.TestCase
{
    private final Spielfeld _spielfeld;
    
    /**
     * Jede Testmethode wird auf einem frischen Exemplar aufgerufen.
     */
    public SpielfeldTest()
    {
        _spielfeld = new SpielfeldArray();
    }

    /**
     * Stellt sicher, dass ein neues Spielfeld leer ist.
     */
    public void testNeuesSpielfeldIstLeer()
    {
        assertFalse(_spielfeld.istSpielfeldVoll());
        for (int spalte = 0; spalte < Spielfeld.BREITE; ++spalte)
        {
            assertFalse(_spielfeld.istSpalteVoll(spalte));
            for (int zeile = 0; zeile < Spielfeld.HOEHE; ++zeile)
            {
                assertEquals(0, _spielfeld.gibBesitzer(zeile, spalte));
            }
        }
    }

    /**
     * Stellt sicher, dass die Spieler nicht ignoriert werden.
     */
    public void testSpielerWerdenBeruecksichtigt()
    {
        _spielfeld.legeSpielsteinAb(0, 1);
        assertEquals(1, _spielfeld.gibBesitzer(0, 0));

        _spielfeld.legeSpielsteinAb(0, 1);
        assertEquals(1, _spielfeld.gibBesitzer(1, 0));

        _spielfeld.legeSpielsteinAb(0, 2);
        assertEquals(2, _spielfeld.gibBesitzer(2, 0));
        
        _spielfeld.legeSpielsteinAb(0, 1);
        assertEquals(1, _spielfeld.gibBesitzer(3, 0));
    }
    
    /**
     * Stellt sicher, dass die Spalten nicht ignoriert werden.
     */
    public void testSpaltenWerdenBeruecksichtigt()
    {
        assertEquals(0, _spielfeld.gibBesitzer(0, 0));
        _spielfeld.legeSpielsteinAb(0, 1);
        assertEquals(1, _spielfeld.gibBesitzer(0, 0));

        assertEquals(0, _spielfeld.gibBesitzer(0, 1));
        _spielfeld.legeSpielsteinAb(1, 2);
        assertEquals(2, _spielfeld.gibBesitzer(0, 1));
    }
    
    /**
     * Stellt sicher, dass ein volles Spielfeld voll ist.
     */
    public void testVollesSpielfeldIstVoll()
    {
        for (int spalte = 0; spalte < Spielfeld.BREITE; ++spalte)
        {
            for (int zeile = 0; zeile < Spielfeld.HOEHE; ++zeile)
            {
                _spielfeld.legeSpielsteinAb(spalte, 1);
            }
            assertTrue(_spielfeld.istSpalteVoll(spalte));
        }
        assertTrue(_spielfeld.istSpielfeldVoll());
    }

    /**
     * Stellt sicher, dass alle Spalten von 0 bis inkl. grenzSpalte voll sind
     * und alle Spalten rechts von grenzSpalte frei.
     */
    private void vollBisInklusive(int grenzSpalte)
    {
        for (int spalte = 0; spalte <= grenzSpalte; ++spalte)
        {
            assertTrue(_spielfeld.istSpalteVoll(spalte));
        }
        for (int spalte = grenzSpalte + 1; spalte < Spielfeld.BREITE; ++spalte)
        {
            assertFalse(_spielfeld.istSpalteVoll(spalte));
        }
    }
}
