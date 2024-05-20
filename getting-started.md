# Lido Validator Ejector for Obol

## Overview
This package aims to provide a simple way to eject Lido validators for those operators running an Obol cluster on Dappnode.

## Prerequisites
Before you begin, ensure that you meet the following requirements:
- An active Obol package is installed on your Dappnode.
- Your Obol package includes a Lido cluster as one of its services.
- A backup of the Obol package has been created after setting up your Lido cluster.

## Installation and Configuration

### Step 1: Restore Backup
1. Navigate to the [Backup tab](http://my.dappnode/packages/my/obol-lido-ejector-holesky.dnp.dappnode.eth/backup).
2. Click on the "Restore" button to upload the Obol backup file you previously downloaded.

### Step 2: Configure Cluster Settings
1. Visit the [Config tab](http://my.dappnode/packages/my/obol-lido-ejector-holesky.dnp.dappnode.eth/config).
2. Set the `CHARON_TO_EXIT_NUMBER` for both the `validator-ejector` and `lido-dv-exit` services. This number should correspond to the number of your Lido cluster inside the Obol package (choose from 1-5).

### Step 3: Set Operator ID
- In the same Config tab, specify the `OPERATOR_ID`, which should be consistent across all operators in the cluster.

## Final Steps
Ensure that both the `validator-ejector` and `lido-dv-exit` services are active, along with the Obol package itself.

## Note
- If the `CHARON_TO_EXIT_NUMBER` and `OPERATOR_ID` were set during the initial installation, there's no need to configure them again unless changes are necessary. In such cases, adjustments can be made through the Config tab mentioned above.
