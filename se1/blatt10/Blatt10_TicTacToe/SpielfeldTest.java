/**
 * Eine Testklasse fuer Spielfeld-Klassen.
 *
 * @author  Christian Spaeh
 * @version Dezember 2010
 */
public class SpielfeldTest extends junit.framework.TestCase
{

    /**
     * Schreibt in diesen Kommenatr, was diese Methode testet:
     * 
     * 
     */
    public void test1()
    {
        Spielfeld spielfeld = neuesSpielfeld();
        
        for(int i = 0; i < 3; i++)
        {
            for(int j = 0; j < 3; j++)
            {
                assertEquals(0, spielfeld.gibBesitzer(i,j));

                spielfeld.besetzePosition(i,j,1);
                assertEquals(1, spielfeld.gibBesitzer(i,j));
        
                spielfeld.besetzePosition(i,j,2);
                assertEquals(2, spielfeld.gibBesitzer(i,j));
                
                spielfeld.besetzePosition(i,j,0);
                assertEquals(0, spielfeld.gibBesitzer(i,j));
            }
        }
    }

    /**
     * Testet, ob ein nicht vollstaendig besetztes Spielfeld
     * als nicht voll und ein vollstaendig besetztes Spielfeld
     * als voll erkannt wird.
     */
    public void testIstVoll()
    {
        Spielfeld spielfeld = neuesSpielfeld();
        for(int i = 0; i < 3; i++)
        {
            for(int j = 0; j < 3; j++)
            {
                assertFalse(spielfeld.istVoll());
                spielfeld.besetzePosition(i,j,1);
             }
        }
        assertTrue(spielfeld.istVoll());
    }
    
    /**
     * Macht die Gegenprobe, dass nur ein Spielfeld,
     * dass an allen 9 verschiedenen Positionen besetzt ist,
     * als voll erkannt wird.
     */
    public void testIstNichtVoll()
    {
        Spielfeld spielfeld = neuesSpielfeld();
        for (int i = 0; i < 9; ++i)
        {
            spielfeld.besetzePosition(0, 0, 1);
        }
        assertFalse(spielfeld.istVoll());
    }

    /**
     * @return ein neues Spielfeld.
     */
    private Spielfeld neuesSpielfeld()
    {
        return new SpielfeldArray();
    }
}
