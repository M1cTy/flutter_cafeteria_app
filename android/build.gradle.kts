allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Set custom build directory for root project
rootProject.buildDir = file("../../build")

subprojects {
    // Set custom build directory for each subproject
    buildDir = rootProject.file("../../build/${project.name}")
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
