# Create the GitLab CI database
CREATE DATABASE IF NOT EXISTS `gitlab_ci_production` DEFAULT CHARACTER SET `utf8` COLLATE `utf8_unicode_ci`;

# Create the MySQL User change $password to a real password
CREATE USER 'gitlab_ci'@'localhost' IDENTIFIED BY 'password';

# Grant proper permissions to the MySQL User
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER ON `gitlab_ci_production`.* TO 'gitlab_ci'@'localhost';

