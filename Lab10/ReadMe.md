Lab 10 README
Project: Self Guided AZ104 - Using Done Right Tech Company Resources

Objective
The goal of this lab is to establish a comprehensive visibility layer for the Done Right Tech Company infrastructure. By implementing Azure Monitor and Log Analytics, we transition from reactive to proactive administration. This lab demonstrates how to centralize log data, define automated notification paths, and set performance thresholds to ensure application stability.

Technical Tasks

Log Analytics Implementation: Provisioning a centralized workspace for cross-resource data aggregation and Kusto Query Language (KQL) analysis.

Alert Orchestration: Configuring Metric Alerts to monitor real-time compute health (CPU Utilization).

Incident Response Automation: Establishing Action Groups to provide instant email notifications to the IT team upon threshold breaches.

Diagnostic Instrumentation: Programmatically linking Virtual Machines to the monitoring workspace to enable metric and log streaming.

Monitoring Architecture

1. Log Analytics Workspace (LAW-DRTC-PROD)

Role: The secure repository for all telemetry data.

Retention: Configured for a 30-day rolling window to optimize costs while providing sufficient historical data for troubleshooting.

2. Action Groups (AG-DRTC-IT)

Notification Type: Email.

Target: WillH@drtc.net.

Benefit: Ensures that the IT team is notified within minutes of a performance degradation, reducing the Mean Time to Resolution (MTTR).

3. Metric Alerts

Scope: VM-WEB-01.

Condition: Triggers when average CPU usage remains above 80% for a 5-minute window.

Strategic Value: Protects the user experience by identifying overloaded servers before they lead to application timeouts.

Deployment Instructions

Prerequisites: Lab 08 (Virtual Machines) must be complete so the monitoring rules have a target resource to attach to.

Execution:

chmod +x deploy_lab10.sh

./deploy_lab10.sh

Verification
Confirm the alert rule is active via the CLI:
az monitor metrics alert list --resource-group RG-AZ104-PROD --output table

You can also simulate high CPU usage on the VM (using a tool like Stress-ng or a simple PowerShell loop) to trigger a live email notification.