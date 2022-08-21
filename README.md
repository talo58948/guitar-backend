# guitar-backend
## Installation And Set Up
- Install .NET 6 in whichever way suits your OS if not installed already.
- Clone this repository.
- In the root directory of this project, open terminal and run:
```
dotnet restore
```
- Install MySql in whichever way suits your OS, if not installed already.
- In the root directory of this project, open terminal and run:
```
mysql -u <YOUR MYSQL USERNAME> -p guitar-db < db.sql
```
- Open appsettings.json and follow the instructions marked with a red line:
![Appsettings json notation](https://user-images.githubusercontent.com/73689715/185805938-fe245734-c73f-4388-8d2d-8c53799d224c.png)
That should be enough for normal CRUD operations using the API. 
In order to run it, from the root directory of this project, open terminal and run:
```
dotnet run
```
### Set Up the Payment Gateway with Braintree.
- Register an account in Braintree.
- Get your merchant ID, and the testing private and secret keys.
- Open appsettings.json and follow the instructions marked with a red line:
![Appsettings json notation](https://user-images.githubusercontent.com/73689715/185806030-a59b6f65-0f87-4a66-9ac2-27ded013152f.png)
## Run
- From the root directory of the project, run in terminal: 
```
dotnet run
```
