#### On RHEL 8.x server

1. Install Python latest version  (on Control node and Managed host)
   ```sh 
   yum install python3 -y
   ```

2. By default, python3 is the command to run python commands. to use just python, use "alternatives" command.  (on Control node and Managed host)
   ```sh 
   alternatives --set python /usr/bin/python3
   ```

3. Check for Python version
   ```sh 
   python --version
   ```
4. Install python-pip package manager  (on Control node)
   ```sh 
   yum -y install python3-pip
   ```
