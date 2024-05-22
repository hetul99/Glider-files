#!/bin/bash

# Update packages
sudo yum update -y

# Install Java
sudo yum install -y java-1.8.0-openjdk

# Download and install Tomcat
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.54/bin/apache-tomcat-9.0.54.tar.gz
tar xzf apache-tomcat-9.0.54.tar.gz
sudo mv apache-tomcat-9.0.54 /usr/local/tomcat9

# Start Tomcat
sudo /usr/local/tomcat9/bin/startup.sh

# Create a script to check if Tomcat is running and start it if it's not
cat <<EOL > /home/ec2-user/check_tomcat.sh
#!/bin/bash

# Check if Tomcat is running
if pgrep -f 'tomcat' > /dev/null
then
    echo "Tomcat is running."
else
    echo "Tomcat is not running. Starting Tomcat..."
    sudo /usr/local/tomcat9/bin/startup.sh
fi
EOL

# Make the check script executable
chmod +x /home/ec2-user/check_tomcat.sh

# Schedule the script to run at 6 AM every weekday
(crontab -l 2>/dev/null; echo "0 6 * * 1-5 /home/ec2-user/check_tomcat.sh") | crontab -


# https://stackoverflow.com/questions/3944157/is-tomcat-running
# https://stackoverflow.com/questions/43405653/how-to-grep-tomcat-pid-in-shell
# https://archive.apache.org/dist/tomcat/tomcat-9/
# https://tecadmin.net/install-tomcat-9-on-centos-8/
