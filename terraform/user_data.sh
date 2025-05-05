#!/bin/bash
              apt-get install -y apache2

              systemctl start apache2

              systemctl enable apache2

              # Create a simple HTML page
              echo "Hello, World! This is a web server running on Apache." > /var/www/html/index.html
              EOF