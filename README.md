Creates grails project with predefined template (file structure, dependencies, scripts etc) created by the Organisation

---

> Usage : grails-create-app grailsVersion appName

> Example: grails-create-app 2.3.6 helloApp

## Creating Template for Grails 2.x 
### Clone this project and `cd TO_CLONED_DIR`
#### Change Grails version to whatever version template you want to create.

> Eg. gvm use grails 2.3.7

#### grails create-app template_2_3_7 

> Project Name is important. It should be "tempalte_${version.replacAll('.', '_')}"

#### Edit template_2_3_7/grails-app/conf/Config.groovy
 Uncomment these to enable reading of external config file. External Config file will be copied to grails-app/conf dir which contains database related configurations and default pacakage for artifacts. This file is added to .gitignore list so that your credentials are not pushed to git.

```groovy
grails.config.locations = [ "classpath:${appName}-config.properties",
                             "classpath:${appName}-config.groovy",
                             "file:${userHome}/.grails/${appName}-config.properties",
                             "file:${userHome}/.grails/${appName}-config.groovy"]
```
#### Edit template_2_3_7/grails-app/conf/Datasource.groovy Change driverClass like this

```groovy
dataSource {
    pooled = true
    jmxExport = true
    driverClassName = 'com.mysql.jdbc.Driver'
    username = "configure this in external appName-config.groovy file"
    password = "configure this in external appName-config.groovy file"
}
```
 
 Other details lilke username, password, database url etc are configured in external config file.

#### Edit template_2_3_7/grails-app/conf/BuildConfig.groovy and uncommennt mysql jar dependency.
```groovy
dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.
        runtime 'mysql:mysql-connector-java:5.1.27'
        // runtime 'org.postgresql:postgresql:9.3-1100-jdbc41'
}
```
