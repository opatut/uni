import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.net.URL;

import javax.swing.ImageIcon;
import javax.swing.JFileChooser;
import javax.swing.JFrame;

/**
 * Eine Klasse zum Einlesen von Bilddaten.
 * 
 * @author Bruce Quig
 * @author Michael Koelling
 * @author Axel Schmolitzky
 * @author Fredrik Winkler
 * @version 20. Dezember 2011
 */
class BildEinleser
{
    private static JFrame _frame = null;
    private static JFileChooser _fileChooser = null;

    /**
     * Lies eine GIF-Datei ein und liefere die Bilddaten als Array. Die Datei wird interaktiv vom
     * Benutzer gewaehlt.
     */
    public static short[][] liesBilddaten()
    {
        if (_fileChooser == null)
        {
            _fileChooser = new JFileChooser(System.getProperty("user.dir") + "/bilder");
            _frame = new JFrame();
            _frame.pack();
            _frame.setAlwaysOnTop(true);
        }

        int returnVal = _fileChooser.showOpenDialog(_frame);

        if (returnVal != JFileChooser.APPROVE_OPTION)
        {
            return null;
        }

        String fileName = _fileChooser.getSelectedFile().getPath();
        Image image = new ImageIcon(fileName).getImage();
        BufferedImage bimage = toBufferedImage(image);

        return toByteArray(bimage);

    }

    /**
     * Lies eine GIF-Datei ein und liefere die Bilddaten als Array. Der Name der Datei wird im
     * CLASSPATH gesucht, unter anderem auch im Projekt-Verzeichnis.
     */
    public static short[][] liesBilddaten(String dateiname)
    {
        Image image;

        URL imageURL = new BildEinleser().getClass().getClassLoader().getResource(dateiname);
        if (imageURL == null) return null;

        image = new ImageIcon(imageURL).getImage();
        // Image image = new ImageIcon(fileName).getImage();
        BufferedImage bimage = toBufferedImage(image);

        return toByteArray(bimage);
    }

    private static BufferedImage toBufferedImage(Image image)
    {
        // This code ensures that all the pixels in
        // the image are loaded.
        image = new ImageIcon(image).getImage();

        // Create the buffered image.
        BufferedImage bufferedImage = new BufferedImage(image.getWidth(null),
                image.getHeight(null), BufferedImage.TYPE_INT_RGB);

        // Copy image to buffered image.
        Graphics g = bufferedImage.createGraphics();

        // Clear background and paint the image.
        g.setColor(Color.white);
        g.fillRect(0, 0, image.getWidth(null), image.getHeight(null));
        g.drawImage(image, 0, 0, null);
        g.dispose();

        return bufferedImage;
    }

    private static short[][] toByteArray(BufferedImage image)
    {
        Raster raster = image.getData();
        int width = raster.getWidth();
        int height = raster.getHeight();

        short[][] bytes = new short[height][width];

        int[] intarr = new int[3]; // rgb values
        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                raster.getPixel(x, y, intarr);
                bytes[y][x] = (short) ((intarr[0] + intarr[1] + intarr[2]) / 3);
            }
        }
        return bytes;
    }
}
