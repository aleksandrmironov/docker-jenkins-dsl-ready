freeStyleJob('fetchr-build') {
    wrappers {
        preBuildCleanup()
        colorizeOutput()
    }
    multiscm {
         git {
            remote {
                url('https://github.com/talal-shobaita/hello-world.git')
            }
            branch('master')
            extensions{
                relativeTargetDirectory('app')
            }
        }
        git {
            remote {
                url('https://github.com/aleksandrmironov/fetchr-samples.git')
            }
            branch('master')
            extensions{
                relativeTargetDirectory('tools')
                cloneOptions {
                    shallow(shallow = true)
                }
                disableRemotePoll()
            }
        }
    }

    steps {
        shell(readFileFromWorkspace('fetchr.sh'))
    }
}
