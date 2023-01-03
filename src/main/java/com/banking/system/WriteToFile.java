package com.banking.system;

import java.io.FileWriter;
import java.io.IOException;

public class WriteToFile {
	
	
	
	public static void writeFile(String fname) {
		
		
		try {
			
		      FileWriter myWriter = new FileWriter(fname);
		      
		      myWriter.write("Files in Java might be tricky, but it is fun enough!");
		      myWriter.close();
		      
		      System.out.println("Successfully wrote to the file.");
		    } catch (IOException e) {
		    	
		      System.out.println("An error occurred.");
		      e.printStackTrace();
		    }

		
	}
	
	
}
