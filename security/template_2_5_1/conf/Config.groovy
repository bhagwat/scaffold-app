
// === Spring Security configuration
// Uncomment following to use optimistic approach for security.
// grails.plugin.springsecurity.rejectIfNoRule = false
// grails.plugin.springsecurity.fii.rejectPublicInvocations = false
grails.plugin.springsecurity.userLookup.userDomainClassName = 'com.manvendrask.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'com.manvendrask.UserRole'
grails.plugin.springsecurity.authority.className = 'com.manvendrask.Role'
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
    '/':                              ['permitAll'],
    '/index':                         ['permitAll'],
    '/index.gsp':                     ['permitAll'],
    '/assets/**':                     ['permitAll'],
    '/**/js/**':                      ['permitAll'],
    '/**/css/**':                     ['permitAll'],
    '/**/images/**':                  ['permitAll'],
    '/**/favicon.ico':                ['permitAll'],
    '/login/**':                      ['permitAll'],
    '/register/**':                   ['permitAll']
]