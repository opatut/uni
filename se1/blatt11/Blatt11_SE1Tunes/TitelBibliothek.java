import java.io.*;
import java.util.Set;
import java.util.HashSet;
import java.util.Random;

/**
 * Die Klasse TitelBibliothek implementiert eine einfache Datenbasis von
 * Musiktiteln.
 * 
 * @author Axel Schmolitzky, Fredrik Winkler
 * @version September 2011
 */
class TitelBibliothek
{
    private Set<Titel> _bibliothek;
    private Titel[] _titelArray;
    private Random _zufallsgenerator;

    /**
     * Initialisiert die TitelBibliothek aus der angegebenen Datei
     * 
     * @param bibliotheksdatei
     *            der Name einer Datei mit Titelinformationen
     */
    public TitelBibliothek(String bibliotheksdatei)
    {
        _bibliothek = new HashSet<Titel>();
        einlesenAusDatei(bibliotheksdatei);
        _titelArray = _bibliothek.toArray(new Titel[_bibliothek.size()]);
        _zufallsgenerator = new Random();
    }

    /**
     * Initialisiert die TitelBibliothek aus der Datei JazzMix.txt
     */
    public TitelBibliothek()
    {
        this("JazzMix.txt");
    }
    
    /**
     * Liefere einen zufaelligen Titel aus dieser Bibliothek.
     */
    public Titel gibZufaelligenTitel()
    {
        return _titelArray[_zufallsgenerator.nextInt(_titelArray.length)];
    }

    /**
     * Gib alle Titel in dieser Bibliothek auf die Konsole aus.
     */
    public void ausgebenAufKonsole()
    {
        for (Titel titel : _bibliothek)
        {
            System.out.println(titel);
        }
    }

    /**
     * Liest Titelinformationen aus einer Textdatei ein. Jeder Titel steht in
     * einer eigenen Zeile.
     * 
     * @param dateiName
     *            der Dateiname der Textdatei
     */
    private void einlesenAusDatei(String dateiName) 
    {
        BufferedReader reader = null;
        try
        {
            reader = new BufferedReader(new FileReader(dateiName));
            String zeile;
            while ((zeile = reader.readLine()) != null)
            {
                verarbeiteZeile(zeile);
            }
        }
        catch (IOException e)
        {
            System.out.println(e);
        }
        finally
        {
            closeSilently(reader);
        }
    }

    private void verarbeiteZeile(String zeile)
    {
        String[] felder = zeile.split("\t");
        if (!felder[6].equals("Jahr")) // Kopfzeile ignorieren
        {
            Titel titel = new Titel(felder[0], // Name
                    felder[1], // Interpret
                    felder[2], // Album
                    Integer.parseInt(felder[6]), // Jahr
                    felder[3], // Genre
                    Integer.parseInt(felder[4])); // Dauer
            _bibliothek.add(titel);
        }
    }

    private static void closeSilently(Closeable closeable)
    {
        if (closeable != null)
        {
            try
            {
                closeable.close();
            }
            catch (IOException ignore)
            {
            }
        }
    }
}
