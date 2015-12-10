<%@ page import="java.sql.*" %>
<%!
	private Connection conn = null;

	private String getRndPassword() {
		// Dont want to make things too easy ;)
		StringBuffer sb = new StringBuffer();
		int passwordSize = 5 + (int)(Math.random() * 10);
		for (int i = 0; i < passwordSize; i++) {
			int start = Character.valueOf('0').charValue();
			int end = Character.valueOf('z').charValue();
			int charValue = start + (int)(Math.random() * (end - start));
				sb.append((char)charValue);
		}
	    return sb.toString();
	}

	private String getRndDesc() {
		StringBuffer sb = new StringBuffer();
		int sentanceSize = 1 +  (int)(Math.random() * 4);
		for (int i = 0; i < sentanceSize; i++) {
			addRndSentance(sb);
		}

		return sb.toString();
	}

	private void addRndSentance(StringBuffer sb) {

		int wordSize = 4 +  (int)(Math.random() * 20);
		addRndWord(sb, true);
		for (int i = 0; i < wordSize; i++) {
			sb.append(" ");
			addRndWord(sb, false);
		}
		sb.append(". ");
	}

	private void addRndWord(StringBuffer sb, boolean capitalise) {
		// Just rubbish ;)
		int wordSize = (int)(Math.random() * 8);
		for (int i = 0; i < wordSize; i++) {
			int start = Character.valueOf('a').charValue();
			int end = Character.valueOf('z').charValue();
			if (capitalise && i == 0) {
	    		start = Character.valueOf('A').charValue();
	    		end = Character.valueOf('Z').charValue();
			}
			int charValue = start + (int)(Math.random() * (end - start));
				sb.append((char)charValue);
		}
	}

	public void jspInit() {
        getServletContext().log("InitServlet init TheBodgeItStore :)");

    	Connection c = null;
    	try {
    		// Get hold of the JDBC driver
    		Class.forName("org.hsqldb.jdbcDriver" );
    	} catch (Exception e) {
    		getServletContext().log("ERROR: failed to load HSQLDB JDBC driver: " + e);
    		return;
    	}
    	try {
    		// Establish a connection to an in memory db
    		c = DriverManager.getConnection("jdbc:hsqldb:mem:SQL", "sa", "");
    	} catch (Exception e) {
    		getServletContext().log("ERROR: failed to make a connection to the db: " + e);
    		return;
    	}

    	try {
			ResultSet rs = c.getMetaData().getColumns(null, null, "Products", "NAME");
			if (!rs.next()) {
				// Create the schema

				// Product type table
				c.prepareStatement("CREATE CACHED TABLE ProductTypes (" +
						"typeid INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY, " +
						"type varchar(50) NOT NULL, " +
						"CONSTRAINT UNIQUE_ProductTypes_type UNIQUE (type) )").execute();

				c.prepareStatement("INSERT INTO ProductTypes (type) VALUES ('Widgets')").execute();
				c.prepareStatement("INSERT INTO ProductTypes (type) VALUES ('Thingies')").execute();
				c.prepareStatement("INSERT INTO ProductTypes (type) VALUES ('Thingamajigs')").execute();
				c.prepareStatement("INSERT INTO ProductTypes (type) VALUES ('Whatsits')").execute();
				c.prepareStatement("INSERT INTO ProductTypes (type) VALUES ('Gizmos')").execute();
				c.prepareStatement("INSERT INTO ProductTypes (type) VALUES ('Doodahs')").execute();
				c.prepareStatement("INSERT INTO ProductTypes (type) VALUES ('Whatchamacallits')").execute();

				// Products table
				c.prepareStatement("CREATE CACHED TABLE Products (" +
						"productid INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY, " +
						"product varchar(50) NOT NULL, desc varchar(5000) NOT NULL, typeid INTEGER NOT NULL, price decimal NOT NULL, " +
						"CONSTRAINT UNIQUE_Products_product UNIQUE (product) )").execute();

				// Load the product data (yes, we could use parameters, but this is possibly a bit clearer ;)
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Basic Widget', '" + getRndDesc() + "', 1, 1.2)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Complex Widget', '" + getRndDesc() + "', 1, 3.1)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Weird Widget', '" + getRndDesc() + "', 1, 4.7)").execute();

				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Thingie 1', '" + getRndDesc() + "', 2, 3.0)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Thingie 2', '" + getRndDesc() + "', 2, 3.2)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Thingie 3', '" + getRndDesc() + "', 2, 3.3)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Thingie 4', '" + getRndDesc() + "', 2, 3.5)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Thingie 5', '" + getRndDesc() + "', 2, 3.7)").execute();

				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('TGJ AAA', '" + getRndDesc() + "', 3, 0.9)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('TGJ ABB', '" + getRndDesc() + "', 3, 1.4)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('TGJ CCC', '" + getRndDesc() + "', 3, 0.7)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('TGJ CCD', '" + getRndDesc() + "', 3, 2.2)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('TGJ EFF', '" + getRndDesc() + "', 3, 3.0)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('TGJ GGG', '" + getRndDesc() + "', 3, 2.6)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('TGJ HHI', '" + getRndDesc() + "', 3, 2.1)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('TGJ JJJ', '" + getRndDesc() + "', 3, 0.8)").execute();

				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Whatsit called', '" + getRndDesc() + "', 4, 4.1)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Whatsit weigh', '" + getRndDesc() + "', 4, 2.5)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Whatsit feel like', '" + getRndDesc() + "', 4, 3.95)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Whatsit taste like', '" + getRndDesc() + "', 4, 3.96)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Whatsit sound like', '" + getRndDesc() + "', 4, 2.9)").execute();

				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('GZ XT4', '" + getRndDesc() + "', 5, 4.45)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('GZ ZX3', '" + getRndDesc() + "', 5, 3.81)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('GZ FZ8', '" + getRndDesc() + "', 5, 1.0)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('GZ K77', '" + getRndDesc() + "', 5, 3.05)").execute();

				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Zip a dee doo dah', '" + getRndDesc() + "', 6, 3.99)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Doo dah day', '" + getRndDesc() + "', 6, 6.50)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Bonzo dog doo dah', '" + getRndDesc() + "', 6, 2.45)").execute();

				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Tipofmytongue', '" + getRndDesc() + "', 7, 3.74)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Mindblank', '" + getRndDesc() + "', 7, 1.00)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Youknowwhat', '" + getRndDesc() + "', 7, 4.32)").execute();
				c.prepareStatement("INSERT INTO Products (product, desc, typeid, price) VALUES ('Whatnot', '" + getRndDesc() + "', 7, 2.68)").execute();

				// Users table
				c.prepareStatement("CREATE CACHED TABLE Users (" +
						"userid INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY, " +
						"name varchar(100) NOT NULL, type varchar(10) NOT NULL, password varchar(30) NOT NULL," +
						"currentbasketid INTEGER NULL, CONSTRAINT UNIQUE_Users_name UNIQUE (name) )").execute();

				// Load the user data
				c.prepareStatement("INSERT INTO Users (name, type, password) VALUES ('user1@thebodgeitstore.com', 'USER', '" + getRndPassword() + "')").execute();
				c.prepareStatement("INSERT INTO Users (name, type, password) VALUES ('admin@thebodgeitstore.com', 'ADMIN', '" + getRndPassword() + "')").execute();
				c.prepareStatement("INSERT INTO Users (name, type, password, currentbasketid) VALUES ('test@thebodgeitstore.com', 'USER', 'password', 1)").execute(); // Ok, so this one is easy:)

				// Baskets table
				c.prepareStatement("CREATE CACHED TABLE Baskets (" +
						"basketid INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY, " +
						"created TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, userid INTEGER NULL)").execute();

				c.prepareStatement("INSERT INTO Baskets (userid) VALUES (3)").execute();

				// Basket Contents table
				c.prepareStatement("CREATE CACHED TABLE BasketContents (" +
						"bcid INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY, " +
						"basketid INTEGER NOT NULL, productid INTEGER NOT NULL, quantity INTEGER NOT NULL, pricetopay decimal NOT NULL" +
						" )").execute();

				c.prepareStatement("INSERT INTO BasketContents (basketid, productid, quantity, pricetopay) VALUES (1, 1, 1, 1.1)").execute();
				c.prepareStatement("INSERT INTO BasketContents (basketid, productid, quantity, pricetopay) VALUES (1, 3, 2, 2.1)").execute();
				c.prepareStatement("INSERT INTO BasketContents (basketid, productid, quantity, pricetopay) VALUES (1, 5, 3, 1.5)").execute();
				c.prepareStatement("INSERT INTO BasketContents (basketid, productid, quantity, pricetopay) VALUES (1, 7, 4, 0.95)").execute();

				// Comments table
				c.prepareStatement("CREATE CACHED TABLE Comments (" +
						"commentid INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY, " +
						"name varchar(100) NULL, " +
						"comment varchar(5000) NOT NULL, " +
						"userid INTEGER NULL )").execute();

                                //Used to identify a successful SQL Injection returning table names.
                                c.prepareStatement("CREATE CACHED TABLE f0ecfb32e56d3845f140e5c81a81363ce61d9d50 (" +
						"GOOD_JOB varchar(2) NULL)").execute();



				// Scoring table
				c.prepareStatement("CREATE CACHED TABLE Score (" +
						"scoreid INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY, " +
						"task varchar(30) NOT NULL, " +
						"description varchar(300) NOT NULL, " +
						"status INTEGER NOT NULL, " +
						"CONSTRAINT UNIQUE_Score_label UNIQUE (task) )").execute();

				c.prepareStatement("INSERT INTO Score (task, description, status) VALUES ('LOGIN_TEST', 'Login as test@thebodgeitstore.com', 0)").execute();
				c.prepareStatement("INSERT INTO Score (task, description, status) VALUES ('LOGIN_USER1', 'Login as user1@thebodgeitstore.com', 0)").execute();
				c.prepareStatement("INSERT INTO Score (task, description, status) VALUES ('LOGIN_ADMIN', 'Login as admin@thebodgeitstore.com', 0)").execute();
				c.prepareStatement("INSERT INTO Score (task, description, status) VALUES ('HIDDEN_ADMIN', 'Find hidden content as a non admin user', 0)").execute();
				c.prepareStatement("INSERT INTO Score (task, description, status) VALUES ('HIDDEN_DEBUG', 'Find diagnostic data', 0)").execute();
                                c.prepareStatement("INSERT INTO Score (task, description, status) VALUES ('SIMPLE_XSS', 'Level 1: Display a popup using: &lt;script&gt;alert(\"XSS\")&lt;/script&gt;', 0)").execute();
				c.prepareStatement("INSERT INTO Score (task, description, status) VALUES ('XSS_USER', 'Level 2: Display a popup using: &lt;script&gt;alert(\"XSS\")&lt;/script&gt;', 0)").execute();
				c.prepareStatement("INSERT INTO Score (task, description, status) VALUES ('XSS_LOGIN', 'Level 3: Display a popup using: &lt;script&gt;alert(\"XSS\")&lt;/script&gt;', 0)").execute();
				c.prepareStatement("INSERT INTO Score (task, description, status) VALUES ('OTHER_BASKET', 'Access someone elses basket', -1)").execute();
				c.prepareStatement("INSERT INTO Score (task, description, status) VALUES ('CSRF_BASKET', 'Force someone to add an item to their basket when they visit your webpage.', 0)").execute();
                                c.prepareStatement("INSERT INTO Score (task, description, status) VALUES ('NEG_BASKET', 'Get the store to owe you money', 0)").execute();
				c.prepareStatement("INSERT INTO Score (task, description, status) VALUES ('PASSWD_GET', 'Change your password via a GET request', 0)").execute();
                                c.prepareStatement("INSERT INTO Score (task, description, status) VALUES ('AES_XSS', 'Conquer AES encryption, and display a popup using: &lt;script&gt;alert(\"H@cked A3S\")&lt;/script&gt;', 0)").execute();
                                c.prepareStatement("INSERT INTO Score (task, description, status) VALUES ('AES_SQLI', 'Conquer AES encryption and append a list of table names to the normal results.', 0)").execute();

			}
			rs.close();
		} catch (SQLException e) {
    		getServletContext().log("ERROR: failed to create the schema or data: " + e);
		} finally {
			try {
				c.close();
			} catch (Exception e) {

			}
		}

	}

	public void jspDestroy() {
	}
%>
