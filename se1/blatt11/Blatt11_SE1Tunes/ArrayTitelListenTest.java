import junit.framework.TestCase;
import java.util.Set;
import java.util.HashSet;

/**
 * JUnit-Test fuer die Klasse ArrayTitelListe.
 * 
 * @author Till Aust, Axel Schmolitzky, Petra Becker-Pechau, Alex Pokahr
 * @version 30. Dezember 2009
 */
public class ArrayTitelListenTest extends TestCase
{

    private Titel[] _testTitel;

    public void setUp()
    {
        TitelBibliothek titelQuelle = new TitelBibliothek("JazzMix.txt");
        _testTitel = new Titel[10];
        Set<Titel> titelMenge = new HashSet<Titel>();
        for (int i = 0; i < 10; i++)
        {
            Titel t = titelQuelle.gibZufaelligenTitel();
            while (titelMenge.contains(t))
            {
                t = titelQuelle.gibZufaelligenTitel();
            }
            _testTitel[i] = t;
            titelMenge.add(t);
        }
    }

    /**
     * Testet die Methode enthaelt(String) der Liste.
     */
    public void testeEnthaelt()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 10; i++)
        {
            titelListe.fuegeEin(_testTitel[i], titelListe.gibLaenge());
        }

        assertTrue("titelListe soll den Test-Titel 0 enthalten", titelListe
                .enthaelt(_testTitel[0]));
        assertTrue("titelListe soll den Test-Titel 2 enthalten", titelListe
                .enthaelt(_testTitel[2]));
        assertTrue("titelListe soll den Test-Titel 9 enthalten", titelListe
                .enthaelt(_testTitel[9]));

        Titel falscherTitel = new Titel("", "", "", 0, "", 0);
        assertFalse(
                "titelListe darf nicht den Titel 'falscherTitel' enthalten",
                titelListe.enthaelt(falscherTitel));
    }
    
    /**
     * Testet, ob zwei Titel in der Methode enthaelt(String) mit equals verglichen 
     * werden. 
     */
    public void testetEqualsVerwendungInEnthaelt()
    {
       TitelListe titelListe = erzeugeListe();
       Titel titel = new Titel("At Saturday", "Esbjoern Svensson Trio", "Winter in Venice", 1999, "Jazz", 374);
       Titel gleicherTitel = new Titel("At Saturday", "Esbjoern Svensson Trio", "Winter in Venice", 1999, "Jazz", 374);
       titelListe.fuegeEin(titel, 0);
       
       assertTrue("titelListe soll gleicherTitel enthalten", titelListe.enthaelt(gleicherTitel));
    }

    /**
     * Testet die Methode gibLaenge der Liste.
     */
    public void testeGibLaenge()
    {
        TitelListe titelListe = erzeugeListe();
        assertEquals(0, titelListe.gibLaenge());

        for (int i = 0; i < 10; i++)
        {
            titelListe.fuegeEin(_testTitel[i], titelListe.gibLaenge());
            assertEquals(i + 1, titelListe.gibLaenge());
        }

        assertEquals(10, titelListe.gibLaenge());
    }

    /**
     * Testet die Methode fuegeEin(Titel, int) der Liste. Dabei wird getestet,
     * ob sich Elemente mittig in die Liste einfuegen lassen.
     */
    public void testeFuegeEinMittig()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 9; i++)
        {
            titelListe.fuegeEin(_testTitel[i], titelListe.gibLaenge());
        }
        titelListe.fuegeEin(_testTitel[9], 5);
        assertEquals(10, titelListe.gibLaenge());
        assertTrue("titelListe soll den Test-Titel 9 enthalten", titelListe
                .enthaelt(_testTitel[9]));
        assertEquals(_testTitel[9], titelListe.gibTitel(5));
        assertEquals(_testTitel[4], titelListe.gibTitel(4));
        assertEquals(_testTitel[5], titelListe.gibTitel(6));
        assertEquals(_testTitel[8], titelListe.gibTitel(9));
    }

    /**
     * Testet die Methode fuegeEin(Titel, int) der Liste. Dabei wird getestet,
     * ob sich Elemente am Anfang in die Liste einfuegen lassen.
     */
    public void testeFuegeEinListenanfang()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 9; i++)
        {
            titelListe.fuegeEin(_testTitel[i], titelListe.gibLaenge());
        }
        titelListe.fuegeEin(_testTitel[9], 0);
        assertEquals(10, titelListe.gibLaenge());
        assertTrue("titelListe soll den Test-Titel 9 enthalten", titelListe
                .enthaelt(_testTitel[9]));
        assertEquals(_testTitel[9], titelListe.gibTitel(0));
        assertEquals(_testTitel[0], titelListe.gibTitel(1));
        assertEquals(_testTitel[8], titelListe.gibTitel(9));
    }

    /**
     * Testet die Methode fuegeEin(String, int) der Liste. Dabei wird getestet,
     * ob sich Elemente am Ende in die Liste einfuegen lassen.
     */
    public void testeFuegeEinListenende()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 10; i++)
        {
            titelListe.fuegeEin(_testTitel[i], titelListe.gibLaenge());
        }
        assertEquals(10, titelListe.gibLaenge());
        assertEquals(_testTitel[0], titelListe.gibTitel(0));
        assertEquals(_testTitel[9], titelListe.gibTitel(9));
    }

    /**
     * Testet, ob beim Einfuegen am Anfang korrekt verschoben wird.
     */
    public void testeEinfuegenUndEntfernen()
    {
        TitelListe titelListe = erzeugeListe();
        titelListe.fuegeEin(_testTitel[6], 0);
        titelListe.fuegeEin(_testTitel[5], 0);
        titelListe.entferne(1);
        assertTrue("titelListe soll den Test-Titel 5 enthalten", titelListe
                .enthaelt(_testTitel[5]));
    }

    /**
     * Testet das Vergroessern der Liste waehrend des Einfuegens vieler
     * Elemente.
     */
    public void testeFuegeEinVergroessern()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 12; i++)
        {
            titelListe.fuegeEin(_testTitel[i % 10], 0);
        }
        assertEquals(12, titelListe.gibLaenge());

        assertEquals(_testTitel[0], titelListe.gibTitel(11));
        assertEquals(_testTitel[1], titelListe.gibTitel(10));
    }

    /**
     * Testet die Methode fuegeEin(String, int) der Liste. Dabei wird getestet,
     * ob sich die Liste richtig verhaelt, wenn man versucht ein Element an
     * ungueltigen Indizes einzufuegen.
     */
    public void testeFuegeEinNegativtest()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 10; i++)
        {
            titelListe.fuegeEin(_testTitel[i], titelListe.gibLaenge());
        }
        boolean exception = false;
        Titel falscherTitel = new Titel("", "", "", 0, "", 0);
        try
        {
            titelListe.fuegeEin(falscherTitel, -1);
        }
        catch (IndexOutOfBoundsException ie)
        {
            exception = true;
        }
        assertTrue("es soll eine Exception aufgetreten sein", exception);
        assertEquals(10, titelListe.gibLaenge());
        assertFalse(
                "titelListe darf nicht den Titel 'falscherTitel' enthalten",
                titelListe.enthaelt(falscherTitel));
        assertEquals(_testTitel[0], titelListe.gibTitel(0));
        assertEquals(_testTitel[9], titelListe.gibTitel(9));

        exception = false;
        try
        {
            titelListe.fuegeEin(falscherTitel, 11);
        }
        catch (IndexOutOfBoundsException ie)
        {
            exception = true;
        }
        assertTrue("es soll eine Exception aufgetreten sein", exception);
        assertEquals(10, titelListe.gibLaenge());
        assertFalse(
                "titelListe darf nicht den Titel 'falscherTitel' enthalten",
                titelListe.enthaelt(falscherTitel));
        assertEquals(_testTitel[0], titelListe.gibTitel(0));
        assertEquals(_testTitel[9], titelListe.gibTitel(9));
    }

    /**
     * Testet die Methode entferne(int) der Liste. Dabei wird getestet, ob sich
     * Elemente mittig aus der Liste entfernen lassen.
     */
    public void testeEntferneMittig()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 10; i++)
        {
            titelListe.fuegeEin(_testTitel[i], titelListe.gibLaenge());
        }
        titelListe.entferne(5);
        assertEquals(9, titelListe.gibLaenge());
        assertFalse("titelListe darf nicht den Test-Titel 5 enthalten",
                titelListe.enthaelt(_testTitel[5]));
        assertEquals(_testTitel[4], titelListe.gibTitel(4));
        assertEquals(_testTitel[6], titelListe.gibTitel(5));
        assertEquals(_testTitel[9], titelListe.gibTitel(8));
    }

    /**
     * Testet die Methode entferne(int) der Liste. Dabei wird getestet, ob sich
     * Elemente am Anfang aus der Liste entfernen lassen.
     */
    public void testeEntferneListenanfang()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 10; i++)
        {
            titelListe.fuegeEin(_testTitel[i], titelListe.gibLaenge());
        }
        titelListe.entferne(0);
        assertEquals(9, titelListe.gibLaenge());
        assertFalse("titelListe darf nicht den Test-Titel 0 enthalten",
                titelListe.enthaelt(_testTitel[0]));
        assertEquals(_testTitel[1], titelListe.gibTitel(0));
        assertEquals(_testTitel[9], titelListe.gibTitel(8));
    }

    /**
     * Testet die Methode entferne(int) der Liste. Dabei wird getestet, ob sich
     * Elemente am Ende aus der Liste entfernen lassen.
     */
    public void testeEntferneListenende()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 10; i++)
        {
            titelListe.fuegeEin(_testTitel[i], titelListe.gibLaenge());
        }
        titelListe.entferne(9);
        assertEquals(9, titelListe.gibLaenge());
        assertFalse("titelListe darf nicht den Test-Titel 9 enthalten",
                titelListe.enthaelt(_testTitel[9]));
        assertEquals(_testTitel[0], titelListe.gibTitel(0));
        assertEquals(_testTitel[8], titelListe.gibTitel(8));
    }

    /**
     * Testet, ob sich Elemente aus einer Liste loeschen lassen, die mehr als 10
     * Elemente enthaelt.
     */
    public void testeLoeschenAusGrosserListe()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 12; i++)
        {
            titelListe.fuegeEin(_testTitel[i % 10], titelListe.gibLaenge());
        }
        titelListe.entferne(0);
        titelListe.entferne(0);
        titelListe.entferne(0);
        assertEquals(9, titelListe.gibLaenge());
        assertEquals(_testTitel[3], titelListe.gibTitel(0));
    }

    /**
     * Testet die Methode entferne(int) der Liste. Dabei wird getestet, ob sich
     * die Liste richtig verhaelt, wenn man versucht ein Element an ungueltigen
     * Indizes zu entfernen.
     */
    public void testeEntferneNegativtest()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 10; i++)
        {
            titelListe.fuegeEin(_testTitel[i], titelListe.gibLaenge());
        }
        boolean exception = false;
        try
        {
            titelListe.entferne(-1);
        }
        catch (IndexOutOfBoundsException ie)
        {
            exception = true;
        }
        assertTrue("es soll eine Exception aufgetreten sein", exception);
        assertEquals(10, titelListe.gibLaenge());
        assertEquals(_testTitel[0], titelListe.gibTitel(0));
        assertEquals(_testTitel[9], titelListe.gibTitel(9));

        exception = false;
        try
        {
            titelListe.entferne(10);
        }
        catch (IndexOutOfBoundsException ie)
        {
            exception = true;
        }
        assertTrue("es soll eine Exception aufgetreten sein", exception);
        assertEquals(10, titelListe.gibLaenge());
        assertEquals(_testTitel[0], titelListe.gibTitel(0));
        assertEquals(_testTitel[9], titelListe.gibTitel(9));
    }

    /**
     * Testet die Methode gibTitel(int) der Liste. Dabei wird getestet, ob sich
     * Elemente mittig in der Liste abfragen lassen.
     */
    public void testeGibMittig()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 10; i++)
        {
            titelListe.fuegeEin(_testTitel[i], titelListe.gibLaenge());
        }
        assertEquals(_testTitel[5], titelListe.gibTitel(5));
        assertEquals(10, titelListe.gibLaenge());
        assertTrue("titelListe soll den Test-Titel 5 enthalten", titelListe
                .enthaelt(_testTitel[5]));
    }

    /**
     * Testet die Methode gibTitel(int) der Liste. Dabei wird getestet, ob sich
     * Elemente am Anfang in der Liste abfragen lassen.
     */
    public void testeGibListenanfang()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 10; i++)
        {
            titelListe.fuegeEin(_testTitel[i], titelListe.gibLaenge());
        }
        assertEquals(_testTitel[0], titelListe.gibTitel(0));
        assertEquals(10, titelListe.gibLaenge());
        assertTrue("titelListe soll den Test-Titel 0 enthalten", titelListe
                .enthaelt(_testTitel[0]));
    }

    /**
     * Testet die Methode gibTitel(int) der Liste. Dabei wird getestet, ob sich
     * Elemente am Ende in der Liste abfragen lassen.
     */
    public void testeGibListenende()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 10; i++)
        {
            titelListe.fuegeEin(_testTitel[i], titelListe.gibLaenge());
        }
        assertEquals(_testTitel[9], titelListe.gibTitel(9));
        assertEquals(10, titelListe.gibLaenge());
        assertTrue("titelListe soll den Test-Titel 9 enthalten", titelListe
                .enthaelt(_testTitel[9]));
    }

    /**
     * Testet die Methode gibTitel(int) der Liste. Dabei wird getestet, ob sich
     * die Liste richtig verhaelt, wenn man versucht ein Element an ungueltigen
     * Indizes abzufragen.
     */
    public void testeGibNegativtest()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 10; i++)
        {
            titelListe.fuegeEin(_testTitel[i], titelListe.gibLaenge());
        }
        boolean exception = false;
        try
        {
            titelListe.gibTitel(-1);
        }
        catch (IndexOutOfBoundsException ie)
        {
            exception = true;
        }
        assertTrue(exception);
        assertEquals(10, titelListe.gibLaenge());
        assertEquals(_testTitel[0], titelListe.gibTitel(0));
        assertEquals(_testTitel[9], titelListe.gibTitel(9));

        exception = false;
        try
        {
            titelListe.gibTitel(10);
        }
        catch (IndexOutOfBoundsException ie)
        {
            exception = true;
        }
        assertTrue(exception);
        assertEquals(10, titelListe.gibLaenge());
        assertEquals(_testTitel[0], titelListe.gibTitel(0));
        assertEquals(_testTitel[9], titelListe.gibTitel(9));
    }

    /**
     * Testet die Methode leere der Liste.
     */
    public void testeLeere()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 10; i++)
        {
            titelListe.fuegeEin(_testTitel[i], titelListe.gibLaenge());
        }
        assertEquals(10, titelListe.gibLaenge());
        titelListe.leere();
        assertEquals(0, titelListe.gibLaenge());
        assertFalse("titelListe darf nicht den Test-Titel 0 enthalten",
                titelListe.enthaelt(_testTitel[0]));
        assertFalse("titelListe darf nicht den Test-Titel 9 enthalten",
                titelListe.enthaelt(_testTitel[9]));
    }

    /**
     * Testet das Vergroessern der Liste waehrend des Einfuegens vieler
     * Elemente.
     */
    public void testeVergroessern()
    {
        TitelListe titelListe = erzeugeListe();
        for (int i = 0; i < 100; i++)
        {
            titelListe.fuegeEin(_testTitel[i % 10], 0);
        }
        assertEquals(100, titelListe.gibLaenge());

        for (int i = 0; i < 100; i++)
        {
            assertEquals(_testTitel[i % 10], titelListe.gibTitel(99-i));
        }
    }

    /**
     * Erzeugt eine neue <code>TitelListe</Code>.
     * 
     * @return Eine leere Liste.
     */
    public TitelListe erzeugeListe()
    {
        return new ArrayTitelListe();
    }
}
