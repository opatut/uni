import java.awt.Polygon;

/**
 * Ein Dreieck, das manipuliert werden kann und sich selbst auf einer
 * Leinwand zeichnet.
 * 
 * @author  Michael Koelling und David J. Barnes
 * @author  Christian Spaeh
 * @version Oktober 2010 
 */
public class Dreieck
{
    private int _hoehe;
    private int _breite;
    private int _xPosition;
    private int _yPosition;
    private String _farbe;
    private boolean _istSichtbar;

    /**
     * Erzeuge ein Dreieck mit einer Standardfarbe an einer Standardposition.
     * Dieses Dreieck ist vorerst unsichtbar.
     */
    public Dreieck()
    {
        _hoehe = 30;
        _breite = 40;
        _xPosition = 50;
        _yPosition = 15;
        _farbe = "gruen";
        _istSichtbar = false;
    }

    /**
     * Mache dieses Dreieck sichtbar. Wenn es bereits sichtbar ist, tue
     * nichts.
     */
    public void sichtbarMachen()
    {
        _istSichtbar = true;
        zeichnen();
    }

    /**
     * Mache dieses Dreieck unsichtbar. Wenn es bereits unsichtbar ist, tue
     * nichts.
     */
    public void unsichtbarMachen()
    {
        loeschen();
        _istSichtbar = false;
    }

    /**
     * Bewege dieses Dreieck einige Bildschirmpunkte nach rechts.
     */
    public void nachRechtsBewegen()
    {
        horizontalBewegen(20);
    }

    /**
     * Bewege dieses Dreieck einige Bildschirmpunkte nach links.
     */
    public void nachLinksBewegen()
    {
        horizontalBewegen(-20);
    }

    /**
     * Bewege dieses Dreieck einige Bildschirmpunkte nach oben.
     */
    public void nachObenBewegen()
    {
        vertikalBewegen(-20);
    }

    /**
     * Bewege dieses Dreieck einige Bildschirmpunkte nach unten.
     */
    public void nachUntenBewegen()
    {
        vertikalBewegen(20);
    }

    /**
     * Bewege dieses Dreieck horizontal.
     * @param entfernung
     *          Die Entfernung in Pixel, um die das Dreieck horizontal bewegt werden soll.
     */
    public void horizontalBewegen(int entfernung)
    {
        loeschen();
        _xPosition += entfernung;
        zeichnen();
    }

    /**
     * Bewege dieses Dreieck vertikal.
     * @param entfernung
     *          Die Entfernung in Pixel, um die das Dreieck vertikal bewegt werden soll.
     */
    public void vertikalBewegen(int entfernung)
    {
        loeschen();
        _yPosition += entfernung;
        zeichnen();
    }

    /**
     * Bewege dieses Dreieck langsam horizontal.
     * @param entfernung
     *          Die Entfernung in Pixel, um die das Dreieck horizontal bewegt werden soll.
     */
    public void langsamHorizontalBewegen(int entfernung)
    {
        int delta;

        if (entfernung < 0)
        {
            delta = -1;
            entfernung = -entfernung;
        }
        else
        {
            delta = 1;
        }

        for (int i = 0; i < entfernung; i++)
        {
            _xPosition += delta;
            zeichnen();
        }
    }

    /**
     * Bewege dieses Dreieck langsam vertikal.
     * @param entfernung
     *          Die Entfernung in Pixel, um die das Dreieck vertikal bewegt werden soll.
     */
    public void langsamVertikalBewegen(int entfernung)
    {
        int delta;

        if (entfernung < 0)
        {
            delta = -1;
            entfernung = -entfernung;
        }
        else
        {
            delta = 1;
        }

        for (int i = 0; i < entfernung; i++)
        {
            _yPosition += delta;
            zeichnen();
        }
    }

    /**
     * Aendere die Groesse dieses Dreiecks.
     * @param neueHoehe
     *          Die neue Hoehe des Dreiecks in Bildschirmpunkten. Diese muss groesser als Null sein.
     * @param neueBreite
     *          Die neue Breite des Dreiecks in Bildschirmpunkten. Diese muss groesser als Null sein.
     */
    public void groesseAendern(int neueHoehe, int neueBreite)
    {
        if((neueHoehe > 0) && (neueBreite > 0)){
            loeschen();
            _hoehe = neueHoehe;
            _breite = neueBreite;
            zeichnen();
        }
    }

    /**
     * Aendere die Farbe dieses Dreiecks.
     * @param neueFarbe
     *          Die neue Farbe des Kreises. Gueltige Angaben sind "rot", "gelb", "blau", "gruen", "lila" und "schwarz".
     */
    public void farbeAendern(String neueFarbe)
    {
        _farbe = neueFarbe;
        zeichnen();
    }

    /*
     * Zeichne dieses Dreieck mit seinen aktuellen Werten auf den Bildschirm.
     */
    private void zeichnen()
    {
        if (_istSichtbar)
        {
            Leinwand leinwand = Leinwand.gibLeinwand();
            int[] xpoints =
                { _xPosition, _xPosition + (_breite / 2), _xPosition - (_breite / 2)};
            int[] ypoints = { _yPosition, _yPosition + _hoehe, _yPosition + _hoehe };
            leinwand.zeichne(this, _farbe, new Polygon(xpoints, ypoints, 3));
            leinwand.warte(10);
        }
    }

    /*
     * Loesche dieses Dreieck vom Bildschirm.
     */
    private void loeschen()
    {
        if (_istSichtbar)
        {
            Leinwand leinwand = Leinwand.gibLeinwand();
            leinwand.entferne(this);
        }
    }
}
