# Node-RED HubSpot Integration

This project implements an automated integration between HubSpot CRM and email notifications using Node-RED. The flow retrieves contact data from HubSpot, processes it, and sends automated email notifications about new or updated contacts.

## Features

- **Data Retrieval**: Fetches contact data from HubSpot CRM API
- **Data Transformation**: Filters and processes contacts based on specified criteria
- **Email Automation**: Sends formatted HTML emails with contact information
- **Error Handling**: Robust error handling for API requests and email transmission
- **Scheduled Execution**: Automated daily runs with manual trigger option
- **Data Persistence**: Tracks processed contacts to prevent duplicate notifications
- **Modular Design**: Uses subflows for reusable components

## Prerequisites

Before running this flow, you'll need:

1. A HubSpot account (free developer account works)
2. HubSpot API credentials (private app access token recommended)
3. SMTP email server access
4. Node-RED (v3.0.0 or later recommended)
5. The following Node-RED nodes:
   - node-red-node-email (for email functionality)

## Installation Options

### Option 1: Direct Installation

1. Install Node-RED if you haven't already:
   ```bash
   npm install -g node-red
   ```

2. Install the required email node:
   ```bash
   cd ~/.node-red
   npm install node-red-node-email
   ```

3. Clone the repository:
   ```bash
   git clone git@github.com:moise10r/node-red-hubspot-integration.git
   cd node-red-hubspot-integration
   ```

4. Copy the flow file to your Node-RED user directory:
   ```bash
   cp flows.json ~/.node-red/
   ```

### Option 2: Docker Installation

1. Clone the repository:
   ```bash
   git clone git@github.com:moise10r/node-red-hubspot-integration.git
   cd node-red-hubspot-integration
   ```



3. Create the data directory and copy the flow file:
   ```bash
   mkdir -p data
   cp flows.json data/flows.json
   ```

4. Start the container:
   ```bash
   docker compose up -d
   ```

5. Access Node-RED at http://localhost:1880

6. Install the required email node:
   - Go to Menu → Manage Palette → Install
   - Search for `node-red-node-email` and install

## Setup Instructions

### 1. Import the flow

If you didn't use the Docker or direct installation methods above:

1. In Node-RED, go to the menu and select Import
2. Copy and paste the JSON flow or upload the flow file
3. Click Import

### 2. Configure HubSpot API credentials

#### Creating a HubSpot Private App and Access Token:

1. Log in to your HubSpot account
2. Go to Settings → Integrations → Private Apps
3. Click "Create private app"
4. Name your app (e.g., "omnipeak Hubspot Integration")
5. Select required scopes:
   - `crm.objects.contacts.read`
6. Click "Create app"
7. Copy the generated access token

#### Configuring the token in Node-RED:

The flow uses Node-RED's secure credential storage:

1. Double-click the `HubSpot API Request` node
2. Under the "Authentication" tab, select "Bearer Authentication"
3. Enter your HubSpot Private App Access Token
4. Click Done


### 3. Configure Email Settings

1. Double-click the `Send Email` node
2. Enter your SMTP server details:
   - Server: smtp.gmail.com
   - Port: 465 
   - User ID: your_email@example.com
   - Password: your_password
3. Configure secure connection options as needed
4. the recipient email address will be set in the `Format Email Message` Node
5. Click Done


To modify the filtering criteria for contacts:

1. Open the `Filter Contacts` Function Node under `Data Processing` Subflow
2. Edit the `Filter Contacts` filter function and update it based your criteria
3. Save changes

### 5. Configure Schedule

By default, the flow runs daily after the first trigger. To change this:

1. Double-click the `Daily Schedule` inject node
2. Modify the cron schedule as needed
3. Click Done

## Flow Components Explained

### Main Flow

- **Trigger**: Trigger the flow either on schedule or manually
- **Get Last Sync Time**: Tracks last run time to filter only new/updated contacts
- **Fetch HubSpot Data**: Retrieves contact data from HubSpot
- **Process & Filter Data**: Processes and filters the contact data
- **Email Preparation/Sending**: Creates and sends formatted emails

- **Update Last Sync Time**: Persists processed contact IDs to avoid duplicates

### Email Subflow

A reusable component for email sending with:
- Configurable SMTP settings
- HTML email formatting
- Error handling

### Error Handling

The flow includes dedicated error handlers for:
- API connection errors (authentication, network issues)
- Email sending failures
- General flow errors

Each error handler formats the error information and logs it appropriately.

## Testing

To test the flow:

1. Deploy the flow
2. Click the button on the `Manual Trigger` inject node
3. Check the debug panel for execution logs
4. Verify that emails are received when new contacts are found


## Security Considerations

This implementation follows security best practices:

1. **Credential Management**:
   - API keys and passwords are stored in Node-RED's secure credential store
   - No sensitive data is stored in plaintext

2. **Error Handling**:
   - All errors are caught and logged appropriately
   - No sensitive data is exposed in error messages

3. **Data Protection**:
   - Only necessary data is retrieved from the API
