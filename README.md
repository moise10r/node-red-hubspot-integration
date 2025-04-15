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

## Setup Instructions

### 1. Import the flow

1. In Node-RED, go to the menu and select Import
2. Copy and paste the JSON flow or upload the flow file
3. Click Import

### 2. Configure HubSpot API credentials

The flow uses Node-RED's secure credential storage:

1. Double-click the "Get HubSpot Contacts" node
2. Under the "Authentication" tab, select "Bearer Authentication"
3. Enter your HubSpot Private App Access Token
4. Click Done

Alternatively, you can set up an environment variable:

```
HUBSPOT_API_KEY=your_api_key_here
```

And modify the function node to use:

```javascript
const apiKey = env.get('HUBSPOT_API_KEY');
```

### 3. Configure Email Settings

#### Option 1: Direct configuration

1. Double-click the "Send Email Notification" node
2. Enter your SMTP server details:
   - Server: smtp.example.com
   - Port: 587 (or as required)
   - User ID: your_email@example.com
   - Password: your_password
3. Configure secure connection options as needed
4. Set the recipient email address
5. Click Done

#### Option 2: Using the Email Subflow (recommended)

1. Double-click the Email Subflow tab
2. Set the environment variables:
   - SMTP_SERVER: smtp.example.com
   - SMTP_PORT: 587
   - SMTP_USER: your_email@example.com
   - SMTP_PASSWORD: your_password
   - DEFAULT_RECIPIENT: recipient@example.com

### 4. Customize Contact Filtering (Optional)

To modify the filtering criteria for contacts:

1. Open the "Filter & Transform Contacts" function node
2. Edit the `industryFilteredContacts` filter function to match your criteria
3. Save changes

### 5. Configure Schedule

By default, the flow runs daily at 8 AM. To change this:

1. Double-click the "Daily Schedule (8 AM)" inject node
2. Modify the cron schedule as needed
3. Click Done

## Flow Components Explained

### Main Flow

- **Scheduler Nodes**: Trigger the flow either on schedule or manually
- **Timestamp Check**: Tracks last run time to filter only new/updated contacts
- **Load/Save Processed IDs**: Persists processed contact IDs to avoid duplicates
- **HubSpot API Request**: Retrieves contact data from HubSpot
- **Filter & Transform**: Processes and filters the contact data
- **Email Preparation/Sending**: Creates and sends formatted email notifications

### Email Subflow

A reusable component for email sending with:
- Configurable SMTP settings
- Default recipient handling
- HTML/plain text email formatting
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
2. Click the button on the "Manual Trigger" inject node
3. Check the debug panel for execution logs
4. Verify that emails are received when new contacts are found

## Troubleshooting

### HubSpot API Issues

- **401 Errors**: Check your API token is valid and not expired
- **403 Errors**: Verify your HubSpot account permissions
- **Rate Limiting**: HubSpot may limit API calls, check debug logs

### Email Issues

- **Connection Failed**: Verify SMTP server details and credentials
- **Authentication Error**: Check username/password
- **TLS/SSL Issues**: Ensure proper security settings

## Extending the Flow

This flow can be extended to:

- Process HubSpot deals instead of/in addition to contacts
- Add filtering by more complex criteria
- Send different email templates based on contact properties
- Integrate with other systems (CRMs, databases, etc.)

## Security Notes

- Never store API keys or passwords in function nodes or flow JSON
- Always use Node-RED's credential encryption
- Consider using environment variables for sensitive information
- Regularly rotate API keys and passwords

## License

This project is available under the MIT License.














# Node-RED HubSpot Integration

This project demonstrates a Node-RED implementation for HubSpot CRM integration, with capabilities for retrieving contact data, processing it, and sending automated email notifications.

## Project Overview

This Node-RED flow automates the following process:
1. Regularly retrieves contact data from HubSpot CRM
2. Processes and filters the data based on specified criteria
3. Sends email notifications about new or updated contacts
4. Tracks processing state to avoid duplicate notifications

The implementation follows a modular design with separate subflows for each functional area, making it easier to maintain and extend.

## Prerequisites

- Node-RED (v3.0.0 or later recommended)
- HubSpot CRM account with API access
- SMTP server for sending emails
- The following Node-RED nodes:
  - node-red-node-email (for email functionality)

## Installation

1. Install Node-RED if you haven't already:
   ```bash
   npm install -g node-red
   ```

2. Install the required email node:
   ```bash
   cd ~/.node-red
   npm install node-red-node-email
   ```

3. Import the flow:
   - Open Node-RED in your browser
   - Click on the menu (≡) and select "Import"
   - Paste the contents of the `node-red-hubspot-flow.json` file
   - Click "Import"

4. Configure the environment variables (see Configuration section below)

5. Deploy the flow

## Configuration

### Security Considerations

This flow uses Node-RED's built-in credentials system to securely store sensitive information. **Never store API keys or passwords in plaintext within the flows.**

### Required Configurations

The following credentials need to be configured:

1. **HubSpot API Key**:
   - Create a Private App in your HubSpot Developer account
   - Generate an access token with the required scopes (contacts, etc.)
   - Set this token in the HubSpot API Subflow's environment variable

2. **Email Settings**:
   - Configure the email node with your SMTP server details
   - Set the recipient and sender email addresses in the Email Notification Subflow's environment variables

### Optional Configurations

1. **Target Industries**:
   - Set specific industries to filter contacts by in the Data Processing Subflow's environment variable

2. **Schedule**:
   - Modify the cron expression in the "Daily Schedule" node to change when the flow runs

## Flow Structure

### Main Flow

The main flow orchestrates the overall process and connects the various subflows. It handles:
- Scheduling through Inject nodes
- Flow control and coordination
- Error handling at the global level

### HubSpot API Subflow

This subflow manages all interactions with the HubSpot API:
- Constructs authenticated API requests
- Handles API responses and errors
- Formats data for further processing

### Data Processing Subflow

This subflow handles all data transformation tasks:
- Extracts relevant fields from API responses
- Normalizes data format
- Filters contacts based on criteria
- Prepares data for notifications

### Email Notification Subflow

This subflow manages the email sending process:
- Formats email content with contact information
- Sends emails using the node-red-node-email node
- Handles email sending errors

### Persistence Subflow

This subflow manages state and prevents duplicate processing:
- Stores the last sync timestamp
- Records processing statistics
- Maintains the state between runs

## Testing

To test the flow:

1. **Manual Testing**:
   - Use the "Manual Trigger" inject node to run the flow on demand
   - Check the debug outputs to verify data is being processed correctly

2. **Configuration Testing**:
   - Use the Configuration tab to verify credentials are working
   - Test with different filtering criteria

3. **Error Handling Testing**:
   - Temporarily disable your network connection to test API error handling
   - Use an invalid API key to verify authentication error handling

## Troubleshooting

Common issues and solutions:

1. **API Connection Problems**:
   - Verify your HubSpot API key is valid and has the necessary permissions
   - Check network connectivity
   - Examine the API Error Log for specific error messages

2. **Email Sending Issues**:
   - Verify SMTP server settings
   - Check if sender email is authorized to send through your SMTP server
   - Review the Email Error Log for detailed error information

3. **No Data Being Processed**:
   - Check if the filter criteria are too restrictive
   - Verify that there are actually new/updated contacts in HubSpot
   - Examine the persistence file to see the last sync timestamp

## Extension Points

The flow is designed to be easily extended:

1. **Additional Data Sources**:
   - Add new API subflows for other HubSpot objects (deals, tickets, etc.)
   - Integrate with other CRM systems

2. **Enhanced Processing**:
   - Add more sophisticated data transformation logic
   - Implement additional filtering criteria

3. **Alternative Notifications**:
   - Add Slack, Microsoft Teams, or other notification channels
   - Create custom reports or dashboards

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
   - Data is processed in memory and not unnecessarily persisted

## License

This project is released under the MIT License.