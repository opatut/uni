/**
 * Diese Klasse modelliert doppelt verkettbare Knoten, die jeweils ein Element
 * vom Typ Titel enthalten koennen.
 * 
 * @author Till Aust, Petra Becker-Pechau, Axel Schmolitzky
 * @version 7. Januar 2010
 */
class DoppellinkKnoten
{
    // Der vorherige Knoten
    private DoppellinkKnoten _vorgaenger;

    // Der nachfolgende Knoten
    private DoppellinkKnoten _nachfolger;

    // Das Element des Knotens, ein Titel
    private Titel _element;

    /**
     * Erzeuge einen neuen Knoten ohne Element und Verkettungsinformationen.
     */
    public DoppellinkKnoten()
    {
    }

    /**
     * Erzeuge einen neuen Knoten und setze gleich Vorgaenger, Nachfolger und
     * Element.
     * 
     * @param element
     *            Das Element, das der Knoten tragen soll
     * @param vorgaenger
     *            Der vorherige Knoten
     * @param nachfolger
     *            Der naechste Knoten
     */
    public DoppellinkKnoten(Titel element, DoppellinkKnoten vorgaenger,
            DoppellinkKnoten nachfolger)
    {
        _element = element;
        _vorgaenger = vorgaenger;
        _nachfolger = nachfolger;
    }

    /**
     * Gib den nachfolgenden Knoten zurueck.
     * 
     * @return den Nachfolgerknoten
     */
    public DoppellinkKnoten gibNachfolger()
    {
        return _nachfolger;
    }

    /**
     * Setze den nachfolgenden Knoten.
     * 
     * @param nachfolger
     *            der Nachfolgerknoten.
     */
    public void setzeNachfolger(DoppellinkKnoten nachfolger)
    {
        _nachfolger = nachfolger;
    }

    /**
     * Gib den vorherigen Knoten zurueck.
     * 
     * @return den Vorgaenger dieses Knotens
     */
    public DoppellinkKnoten gibVorgaenger()
    {
        return _vorgaenger;
    }

    /**
     * Setze den Vorgaenger dieses Knotens.
     * 
     * @param vorgaenger
     *            der Vorgaengerknoten.
     */
    public void setzeVorgaenger(DoppellinkKnoten vorgaenger)
    {
        _vorgaenger = vorgaenger;
    }

    /**
     * Gib das (Daten-)Element dieses Knotens.
     * 
     * @return den gespeicherten Titel dieses Knotens.
     */
    public Titel gibTitel()
    {
        return _element;
    }

    /**
     * Setze das (Daten-)Element dieses Knotens.
     * 
     * @param element
     *            Ein Titel.
     */
    public void setzeTitel(Titel element)
    {
        _element = element;
    }
    
    /**
     * Diese Methode faengt einen typischen Fehler ab, der auftritt,
     * wenn in der Klasse LinkedTitelListe versehentlich ein Kettenglied
     * mit einem Element verglichen wird.
     */
    public boolean equals(Titel titel)
    {
        throw new IllegalArgumentException("Fehler: DoppellinkKnoten mit Titeln zu vergleichen ist nicht sinnvoll!");
    }
}
