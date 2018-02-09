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
                url('https://github.com/aleksandrmironov/docker-jenkins-dsl-ready.git')
            }
            branch('master')
        }
    }
    
    triggers {
        scm('* * * * * ')
    }

    steps {
        shell(readFileFromWorkspace('equitativa.sh'))
    }
}
