# Web Application for Bank Operations

A comprehensive web-based banking system built with PHP and SQL Server that enables complete banking operations for both customers and employees.

## Overview

This banking web application provides a full-featured online banking platform that supports:
- Customer account management and banking operations
- Employee administration and customer service
- Transaction processing and history tracking
- Account balance management
- User authentication and session management

## Technologies Used

- **Frontend:** HTML, CSS, Bootstrap 5, JavaScript (jQuery)
- **Backend:** PHP
- **Database:** Microsoft SQL Server
- **Authentication:** Cookie-based session management
- **UI Framework:** Bootstrap with Font Awesome icons

## Features

### Customer Features
- **Account Dashboard**: View account balance and details
- **Transaction History**: Filter and view transaction records
- **Payment Processing**: Make payments and transfers
- **Profile Management**: Update personal information
- **Secure Login/Logout**: Cookie-based authentication

### Employee Features
- **Customer Management**: Access and manage customer accounts
- **Account Operations**: Process customer transactions
- **Data Administration**: Update customer information
- **Customer Deletion**: Remove customer records when needed

## File Structure

```
├── KorisnikH.php          # Customer dashboard homepage
├── KorisnikL.php          # Customer login page
├── zaposlenH.php          # Employee dashboard homepage
├── zaposlenL.php          # Employee login page
├── zaposlenRacun.php      # Employee account management
├── placanje.php           # Payment processing page
├── profil.php             # User profile management
├── IzbrisiKorisnika.php   # Customer deletion functionality
├── updateKorisnik.php     # Customer data updates
├── funkcije.php           # Core banking functions and business logic
├── konekcijaSaBazom.PHP   # Database connection configuration
├── kod.sql                # Main database schema and procedures
├── bazaIS.sql             # Additional database structures
├── pozivanje.sql          # SQL function calls and procedures
├── zaposlenH.css          # Employee interface styling
└── zaposlenL.css          # Employee login styling
```

## Database Integration

The application integrates with the Diplomski2 banking database system, utilizing:
- **Customer tables** (KORISNIK, RACUN)
- **Transaction processing** (TRANSAKCIJA, TRANSAKCIJA_RACUN)
- **Account management** procedures
- **Stored functions** for business logic

### Key Database Operations
- Account balance retrieval and updates
- Transaction history queries with filtering
- Customer authentication and authorization
- Real-time transaction processing

## Installation

1. **Setup Web Server**
   - Install XAMPP/WAMP with PHP support
   - Ensure SQL Server connectivity

2. **Database Setup**
   ```sql
   -- Import the main database schema
   sqlcmd -S server -E -i kod.sql
   sqlcmd -S server -E -i bazaIS.sql
   ```

3. **Configure Database Connection**
   - Edit `konekcijaSaBazom.PHP` with your SQL Server credentials
   - Update server name and database connection parameters

4. **Deploy Application**
   - Copy all files to web server directory
   - Set appropriate permissions for PHP files

## User Interface

### Customer Interface
- **Dashboard**: Clean view of account information and recent transactions
- **Navigation**: Sidebar with easy access to main functions
- **Transaction Filter**: Search transactions by type (uplata/primanje)
- **Responsive Design**: Bootstrap-based responsive layout

### Employee Interface
- **Administrative Panel**: Tools for customer management
- **Account Access**: View and modify customer account details
- **Customer Operations**: Add, update, or remove customer records

## Security Features

- **Cookie-based Authentication**: Secure session management
- **Role-based Access**: Separate interfaces for customers and employees
- **SQL Server Integration**: Parameterized queries for security
- **Session Validation**: Automatic logout and access control

## Business Logic

### Transaction Processing
- Real-time balance updates
- Transaction history tracking
- Type-based filtering (uploads/receipts)
- Date and time stamping

### Account Management
- Customer profile updates
- Account balance monitoring
- Transaction categorization
- User authentication flow

## API Integration

The web application integrates with the SQL Server stored procedures:
- `prikazivanjeTransakcija()` - Display transaction history
- Account balance functions
- Customer management procedures
- Authentication validation

## Usage

### For Customers
1. Login through `KorisnikL.php`
2. View account dashboard with balance and transactions
3. Use payment functionality for transfers
4. Filter transaction history by type
5. Update profile information

### For Employees
1. Login through `zaposlenL.php`
2. Access customer management tools
3. Process customer requests and updates
4. Manage account operations

## Future Enhancements

- Enhanced security with password hashing
- Real-time notifications
- Mobile application integration
- Advanced reporting features
- Multi-currency support
- Audit trail functionality

## Author

**Mijat Čudić**  
Information Systems Student  
School of Electrical Engineering and Computer Science  
Belgrade, Serbia



## License

This project is for educational purposes as part of Information Systems thesis. 
