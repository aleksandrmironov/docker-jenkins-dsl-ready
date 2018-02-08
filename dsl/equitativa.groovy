freeStyleJob('equitativa-build') {
    parameters {
        stringParam('imap_url', 'ssl://imap.gmail.com', 'IMAP URL')
        stringParam('imap_port', '993', 'IMAP port')
    }
    wrappers {
        preBuildCleanup()
        colorizeOutput()
    }
    scm {
         git {
            remote {
                url('https://github.com/roundcube/roundcubemail.git')
            }
            branch('master')
            extensions{
                relativeTargetDirectory('app')
            }
        }
    }
    
    triggers {
        scm('* * * * * ')
    }

    steps {
        shell(readFileFromWorkspace('equitativa.sh'))
    }
}
