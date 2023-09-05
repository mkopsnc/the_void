package constants;

public class Constants {

  public static int    EMPTY_INT;
  public static double EMPTY_DOUBLE;
  public static char   EMPTY_CHAR;

  static {
    System.loadLibrary("ConstantsJava");
    EMPTY_INT    = getEmptyInt();
    EMPTY_DOUBLE = getEmptyDouble();
    EMPTY_CHAR   = getEmptyChar();
  }

  public static native int    getEmptyInt();
  public static native double getEmptyDouble();
  public static native char   getEmptyChar();

}
