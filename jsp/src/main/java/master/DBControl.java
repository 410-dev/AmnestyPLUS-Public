package master;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBControl {

    public static Connection connection = null;
    public static boolean serverStarted = false;


	public static void refreshQuery() {
		if (!serverStarted) {
			serverStarted = true;
			Thread queryrefresher = new Thread(() -> {
				try {
					System.out.println("Async Thread Start!");
					while (true) {
//						System.out.println("One hour passed. Refreshing DB Query utility.");
						if (DBControl.connection != null) DBControl.connection.close();
						DBControl.connection = null;
						final String ADDRESS = "jdbc:mariadb://localhost:3306/-";
						Class.forName("org.mariadb.jdbc.Driver");
						DBControl.connection = DriverManager.getConnection(ADDRESS, "-", "-");
//						LogsManager.addLog("INFO", "Refreshed DB Connection.");
						DBControl.executeQuery("select * from members where id = 0;");
						Thread.sleep(3600000);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			});
			queryrefresher.start();
		}
	}

	public static ResultSet executeQuery(String toExecute) throws Exception {
		refreshQuery();
		if (connection == null) {
			final String ADDRESS = "jdbc:mariadb://localhost:3306/-";
			Class.forName("org.mariadb.jdbc.Driver");
			connection = DriverManager.getConnection(ADDRESS, "-", "-");
		}
		PreparedStatement statement = null;

		try {
			statement = connection.prepareStatement(toExecute);
		}catch(Exception e) {
			if (e.toString().contains("Broken pipe") || e.toString().contains("java.sql.SQLNonTransientConnectionException") || e.toString().contains("Connection is closed")) {
				connection.close();
				connection = null;
				return executeQuery(toExecute);
			}else{
				throw e;
			}
		}

		return statement.executeQuery();
	}
}
