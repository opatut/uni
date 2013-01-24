/**
 * Die Klasse Titel beschreibt Musiktitel fuer eine Musikdatenbank. Ein Titel
 * hat einen Namen, einen Interpreten, stammt aus einem Album, aus einem Jahr
 * und ist einem Genre zugeordnet.
 * 
 * @author Axel Schmolitzky, Petra Becker-Pechau
 * @version 8. Januar 2010
 */
class Titel
{
    private String _name;
    private String _interpret;
    private String _album;
    private int _jahr;
    private String _genre;
    private int _dauer; // die Dauer dieses Titels in Sekunden

    /**
     * Konstruktor fuer Objekte der Klasse Titel
     */
    public Titel(String name, String interpret, String album, int jahr,
            String genre, int dauer)
    {
        _name = name;
        _interpret = interpret;
        _album = album;
        _jahr = jahr;
        _genre = genre;
        _dauer = dauer;
    }

    /**
     * @return den Namen dieses Titels
     */
    public String gibTitelname()
    {
        return _name;
    }

    /**
     * @return den Interpreten dieses Titels
     */
    public String gibInterpret()
    {
        return _interpret;
    }

    /**
     * @return das Album dieses Titels
     */
    public String gibAlbum()
    {
        return _album;
    }

    /**
     * @return die Laenge dieses Titels in Sekunden
     */
    public int gibLaenge()
    {
        return _dauer;
    }
    
    /**
     * Zwei Titel sind gleich, wenn alle ihre Eigenschaften gleich sind: 
     * Name, Interpret, Album, Jahr, Genre und Dauer.
     */
    public boolean equals(Object object)
    {
        boolean result = false;
        if (object instanceof Titel)
        {
            Titel titel = (Titel) object;
            result = (_name.equals(titel._name) &&  _interpret.equals(titel._interpret) 
                      && _album.equals(titel._album)  &&  _jahr == titel._jahr 
                      &&  _genre.equals(titel._genre) && _dauer == titel._dauer);
        }
        return result;
    }
    
    /**
     * hashCode des Titels. 
     */
    public int hashCode()
    {
        return toString().hashCode();
    }


    /**
     * Erzeugt eine Stringrepraesentation fuer den Titel mit 
     * Interpret, Name, Album und Jahr.
     */
    public String toString()
    {
        return _interpret + ": " + _name + " (" + _album + ", " + _jahr + ")";
    }
}
