import mysql.connector

dataBase = mysql.connector.connect(
    host = "localhost",
    user = "username_of_your_sql",
    passwd = "password_of_your_sql",
    
)

cursorObject = dataBase.cursor()

cursorObject.execute("CREATE DATABASE assignment")

print("Database made")
