# BuildHER_Aleotoken

A transparent & shielded custom token in Leo.

## Overview

This project is based on the BuildHER workshop from Aleo. The original workshop provided a foundational understanding of creating a custom token using Leo. Below are the key changes and enhancements made to the original script.

## Changes Made

1. **Enhanced Token Minting:**
   - Implemented both public and private minting functions for tokens.
   - Added checks to ensure sufficient balances during transfers.

2. **Improved Transfer Functions:**
   - Created functions for transferring tokens between accounts, both publicly and privately.
   - Added assertions to handle insufficient funds gracefully.

3. **Conversion Between Token Types:**
   - Implemented functionality to convert public tokens to private tokens and vice versa.

4. **Environment Management:**
   - Utilized `.env` files to manage sensitive information securely.

5. **Script Automation:**
   - Developed a comprehensive script (`run.sh`) to automate the minting and transferring processes, making it easier to execute multiple operations in sequence.

## Environment Configuration

In this project, we have separated the configurations for Alice and Bob into two distinct `.env` files. This separation was implemented for the following reasons:

1. **Security:** By keeping sensitive information for each account in separate files, we reduce the risk of accidental exposure. Each file contains only the necessary credentials for its respective account.

2. **Clarity:** Having separate environment files makes it easier to manage and understand the configurations for each account. This clarity helps during development and testing, as it allows for quick switching between accounts without modifying a single file.

3. **Flexibility:** This approach allows for easier scaling in the future. If additional accounts need to be added, we can simply create new `.env` files without affecting the existing configurations.

## Script Updates

The original script has been updated to reflect these changes while maintaining the core functionality. The logic for transferring tokens and managing balances remains the same, ensuring that the overall behavior of the token system is consistent with the original implementation from the workshop.

## Run Guide

To run this program, execute the following command:
bash
./run.sh {account1|account2}


Replace `{account1|account2}` with the appropriate account you wish to use.

## Workshop Reference

For a detailed walkthrough of the original implementation, you can watch the BuildHER workshop on YouTube: [BuildHER Workshop](https://www.youtube.com/watch?v=slVmiwqNiRw).

## Acknowledgments

Thanks to the Aleo team for the workshop and resources that helped in building this project.