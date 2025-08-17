#!/bin/bash

echo "Setting password requirements in /etc/login.defs..."

echo "PASS_MIN_LEN 12" >> /etc/login.defs

# Enforce at least 1 uppercase, 1 lowercase, 1 number, 1 special character
# echo "PASS_REGEX ^.*(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:'\"|,<>\.\/?]).*$" >> /etc/login.defs

echo "PASS_MAX_DAYS 90" >> /etc/login.defs
echo "PASS_MIN_DAYS 1" >> /etc/login.defs
echo "PASS_WARN_AGE 7" >> /etc/login.defs

echo "Setting PAM password rules..."

PAM_CONF="/etc/pam.d/common-password"

if ! grep -q "pam_pwquality.so" $PAM_CONF; then
    echo "password requisite pam_pwquality.so retry=3 minlen=12 minclass=4" >> $PAM_CONF
else
    echo "PAM configuration already set."
fi

echo "Password requirements updated successfully."
