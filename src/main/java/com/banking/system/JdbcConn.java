package com.banking.system;

import java.sql.Connection;
import java.sql.DriverManager;

public class JdbcConn {

	private static Connection con = null;

	public static Connection setConnection() {
		
		try {
			
			Class.forName("com.mysql.jdbc.Driver");

			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nationalbank", "root",
					"root");

			// here student is database name, root is username and password: root
			System.out.println("Connection Successfuly Established.......");

		} catch (Exception e) {

			System.out.println(e);
		}

		return con;
	}


}
