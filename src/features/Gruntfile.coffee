module.exports = (grunt, config)->
    features = grunt.expandFileArg 'src/features/integration/users', '**/', '*'

    process.env.SELENIUM_BROWSER = process.env.SELENIUM_BROWSER || 'chrome'

    grunt.Config =
        notify:
            feature:
                options:
                    message: 'Feature Tests Complete.'
        watch:
            features:
                files: features
            tasks:
                [
                    'features'
                    'notify:feature'
                ]
        cucumber:
            integration:
                files:
                    src: features
                options:
                    tags: '~@broken'
            current:
                files:
                    src: features
                options:
                    tags: '@current'

            browserstack:
                options:
                    matrix:
                        "Windows 8.1 1280x1024": [
                            'IE 11.0'
                            'Chrome 36.0'
                        ]
                        "Windows XP 1024x768": [
                            'Firefox 31.0'
                        ]
                        "OS X Mavericks 1920x1080": [
                            'Safari 7.0'
                            'Firefox 31.0'
                            'Chrome 36.0'
                        ]
                        "ios portrait": [
                            'iPad 4th Gen'
                        ]
                        "android landscape": [
                            'Google Nexus 7'
                        ]
            options:
                steps: 'src/features/integration/steps'
                format: 'pretty'
                project: require('../../package').name
                version: require('../../package').version + '-next'
                matrix:
                    'local': ['chrome']

    grunt.NpmTasks = [
        'qcumberbatch'
    ]

    grunt.registerTask 'client-server-launch', ->
        done = @async()
        process.argv = (config.argv or 'node app.js').split ' '
        require(config.server)
        process.env.APP_ROOT = config.app_root or process.env.APP_URL
        setTimeout done, 5e3

    grunt.registerTask 'featuresBrowserstack',
        'Run all feature tests against the full browserstack matrix.',
        [
            # 'selenium-launch'
            'client-server-launch'
            'cucumber:browserstack'
        ]

    grunt.registerTask 'featuresCurrent',
        'Run CucumberJS features tagged @current',
        [
            # 'selenium-launch'
            'client-server-launch'
            'cucumber:current'
        ]

    grunt.registerTask 'features',
        'Run all CucumberJS feature tests.',
        [
            # 'selenium-launch'
            'client-server-launch'
            'cucumber:current'
            'cucumber:integration'
        ]
