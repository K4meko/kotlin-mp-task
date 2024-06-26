plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidLibrary)
    id("app.cash.sqldelight") version "2.0.2"
    kotlin("plugin.serialization") version "1.9.23"

}

kotlin {
    androidTarget {
        compilations.all {
            kotlinOptions {
                jvmTarget = "1.8"
            }
        }
    }
    
    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach {
        it.binaries.framework {
            baseName = "shared"
            isStatic = true
        }
    }

    sourceSets {
        commonMain.dependencies {
            implementation(libs.ktor.client.core)
            implementation(libs.kotlinx.coroutines.core)
            //implementation("app.cash.sqldelight:sqlite-driver:2.0.2")
            implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:1.6.0")

        }
        androidMain.dependencies {
            implementation(libs.ktor.client.okhttp)
            implementation("app.cash.sqldelight:android-driver:2.0.2")

        }
        iosMain.dependencies {
            implementation(libs.ktor.client.darwin)
            implementation("app.cash.sqldelight:native-driver:2.0.2")

        }
        jvmMain.dependencies {
            implementation("app.cash.sqldelight:sqlite-driver:2.0.2")
        }
        commonTest.dependencies {
            implementation(libs.kotlin.test)
        }
    }
}

android {
    namespace = "com.example.kotlinmultiplatformapp"
    compileSdk = 34
    defaultConfig {
        minSdk = 28
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
}
sqldelight {
    databases {
        create("Database") {
            packageName.set("com.crypto.database")
        }
    }
}