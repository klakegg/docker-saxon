import java.util.Arrays;
import net.sf.saxon.Query;
import net.sf.saxon.Transform;

class Main {

  public static void main(String... args) {
    if (args.length == 0)
      transform(args);
    else {
      if (args[0].toLowerCase().equals("query"))
        query(Arrays.copyOfRange(args, 1, args.length));
      else if (args[0].toLowerCase().equals("net.sf.saxon.query"))
        query(Arrays.copyOfRange(args, 1, args.length));
      else if (args[0].toLowerCase().equals("transform"))
        transform(Arrays.copyOfRange(args, 1, args.length));
      else if (args[0].toLowerCase().equals("net.sf.saxon.transform"))
        transform(Arrays.copyOfRange(args, 1, args.length));
      else
        transform(args);
    }
  }

  private static void query(String... args) {
    Query.main(args);
  }

  private static void transform(String... args) {
    Transform.main(args);
  }
}
