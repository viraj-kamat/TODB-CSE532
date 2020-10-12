import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
public class Cumulative_Histogram {
    public static void main(String[] args) {
        try {
            Class.forName("com.ibm.db2.jcc.DB2Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        ResultSet rs=null;
        Connection con = null;
        PreparedStatement pstmt = null;
        int binstart = Integer.parseInt(args[0]);
        int binend = Integer.parseInt(args[1]);
        int numbins = Integer.parseInt(args[2]);
        int binRange = (binend - binstart) / numbins;
        int histogram[] = new int[numbins];
        try {
            con = DriverManager.getConnection("jdbc:db2://localhost:50000/empl", "viraj", "");
            pstmt=con.prepareStatement("select * from EMPLOYEE where salary BETWEEN "+binstart+ " and "+binend );
            rs=pstmt.executeQuery();
            while(rs.next())
            {
                int binIndex = ((int) Float.parseFloat(rs.getString("salary")) - binstart)/ binRange;
                histogram[binIndex] += 1;
            }
        } catch (SQLException exception) {
            exception.printStackTrace();
        }
        
        for (int i = 1; i < histogram.length; i++) {
            histogram[i] += histogram[i-1];
        }
        
        System.out.println("BinIndex\tBinFrequency\tBinStart\tBinEnd");
        for (int i = 0; i < histogram.length; i++) {
            int binEx = binstart + binRange*(i+1);
            System.out.print(i+1 + "\t\t" +histogram[i] + "\t\t" + binstart +"\t\t"+binEx );
            System.out.print("\n");
        }
        

    }
}