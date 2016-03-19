![tools](/art/tools.png)

GWSDroidBuildApp
================

A set of Gradle build scripts for Android Java Application Development following the best practices
of gradle build script construction and employing some android application development best practices.
Because android application development best practices change over time this repo will experience changes
from time-to-time to update to new best practices.

Are we ready yet for 2 billion android devices and users yet?

# Implementation

CAUTION: Many Android Developers are in the opinion that one can do pure POJOs as Models for OOP and
         other just wrong and bone-headed assumptions.  This set of build-scripts takes the opposite tack
         towards such things and looks at best practices differently.

Over-all this set of build scripts implements an INSTRUMENTED-TESTED TDD way fo development as opposed
to a Robolectric Mocked-JVM TDD way for android application development. Also, the prevailing thing is
that we separate android OS framework stuff in isolation testing wise so that we can mock the android OS
framework stuff and the network stuff.

1. In OOP the POJO Models of the big M are implemented as non-pure POJO's with extending the Android OS
   Parceable class as that machinery for maintaining state upon device orientation/configuration change is
   somewhat faster than the Singleton State Manager class machinery that most of us can create and
   we do have the ability to mock parceables.

2. In OOP the ViewModel uses the Google DataBinding when we can and thus also is a non-pure POJO.

3. Except in Library App demos we tend to use a gradle product flavor approach in application development
   as it allows use more flexibility to mock our end-points and other neat tricks.

4. It is assumed that both devices and emulators used for testing have system animations disabled.

# Usage

I deploy my libraries using Jitpack services so in your root build script:

```groovy
allprojects {
        repositories {
            jcenter()
            maven { url "https://jitpack.io" }
        }
   }
```

Than in the module buildscript:


```groovy
compile 'com.github.shareme:GWSDroidBuildApp:{latest-release-number}@aar'
```
the version number is located in the github releases tab at top of what your viewing and do not forget
to leave the at symbol and aar thing in place as it will not work without that suffix.

For this particular set of build scripts, just clone the github repo and modify for your own use.

# SetUp

Certain things used in these build scripts need further set-up than what the build scripts show so
this is the section where that set-up is described.

## Previews of Android Releases

At times we have to test libraries and apps on Android Preview Releases and older production OS
releases concurrently. The set-up to use these build scripts for that is:

in the app module build script
```groovy
android{
     compileSdkVersion 'android-N'
     buildToolsVersion "24.0.0 rc1"

     defaultConfig {
          minSdkVersion 15
          targetSdkVersion 'N'

     }

     buildTypes {
        bc {
            initWith(buildTypes.debug)
            applicationIdSuffix '.bc'
        }
     }
}
//based on http://stackoverflow.com/a/27372806/115145
applicationVariants.all {variant ->
     if (variant.buildType.name=='bc'){
         variant.outputs.each {output->
           ouput.processManifest.doLast {
             def manifestOutFile = output.processManifest.manifestOutputfile
             def xml = new XmlParser().parse(manifestOutFile)
             def usesSdk = xml.'uses-sdk'

             usesSdk.replaceNode {
                 'uses-sdk'('android:minSdkVersion':'15', 'android:targetSdkVersion':'15')
             }
             def fw = new FileWriter(manifestOutFile.toString())
             new XmlNodePrinter(new PrintWriter(fw)).print(xml)
           }
         }
     }
}

```

that gives an N debug build and with the bc build a 15 api build.

## Wire Protocol Buffer SetUp

Protobuffer defs go in the src/main/proto source location when using the wire gradle plugin in the app
modules.

## Timber Set Up

I use a log wrapper in my libraries and applications called Timber created by Jake Wharton. Timber setup:

in the application extended class:

```groovy
public class ExampleApp extends Application {
  @Override public void onCreate() {
    super.onCreate();

    if (BuildConfig.DEBUG) {
      Timber.plant(new DebugTree());
    } else {
      Timber.plant(new CrashReportingTree());
    }
  }

  /** A tree which logs important information for crash reporting. */
  private static class CrashReportingTree extends Timber.Tree {
    @Override protected void log(int priority, String tag, String message, Throwable t) {
      if (priority == Log.VERBOSE || priority == Log.DEBUG) {
        return;
      }

      FakeCrashLibrary.log(priority, tag, message);

      if (t != null) {
        if (priority == Log.ERROR) {
          FakeCrashLibrary.logError(t);
        } else if (priority == Log.WARN) {
          FakeCrashLibrary.logWarning(t);
        }
      }
    }
  }
}


```

and the fake crash library class will be

```groovy
public final class FakeCrashLibrary {
  public static void log(int priority, String tag, String message) {
    // TODO add log entry to circular buffer.
  }

  public static void logWarning(Throwable t) {
    // TODO report non-fatal warning.
  }

  public static void logError(Throwable t) {
    // TODO report non-fatal error.
  }

  private FakeCrashLibrary() {
    throw new AssertionError("No instances.");
  }
}

```

than read your crash library directions to modify the fake crash library class.

## Hugo SetUp

I use the Jake Wharton Hugo gradle plugin to enable annotation triggers in the app modules
so that my method call logging is automated with just doing a DebugLog annotation of the
method such as:

```groovy
@DebugLog
public String getName(String first, String last) {
  SystemClock.sleep(15); // Don't ever really do this!
  return first + " " + last;
}

```

no setup required other than marking the methods with the DebugLog annotation.

## ViewInspector SetUp

I use Fumihiro Xue's ViewInspector gradle plugin to enable inspection of views including
lifecycle events, layers, etc. Because it combines probe and scalpel it does have a little
amount of set-up so as to exclude packages in other libraries that might interfere with it.

to exclude packages

```groovy
viewInspector {
  excludePackages = ['android.widget.Space', 'com.squareup.leakcanary.internal']
}

```

obviously, if packages need to be added you will get an error in the logcat output and know
to add the offending package of the offending library.

## Android Dev Metrics

I use Miroslaw Stanek's Android Dev Metrics Gradle plugin as its better at showing lifecycle
events than the lifecycle gradle plugin and also tracks dagger 2 metrics. It requires this setup
in the extended application class;

```groovy
public class ExampleApplication extends Application {

 @Override
 public void onCreate() {
     super.onCreate();
     //Use it only in debug builds
     if (BuildConfig.DEBUG) {
         AndroidDevMetrics.initWith(this);
     }
  }
 }

```

only shows metrics in the debug build.

## DataInspector

I use Fumihiro Xue's DataInspector gradle plugin to setup debugging SSQlite things such as editing preferences,
editing databases, storage usage and logging of storage events in logcat.

It shows the item menu for it in the tolbar on debug builds but other than applying the plugin
requires no setup.


# ChangeLog

* March 2016, first alpha release with Jack and Jill toolchain not enabled

# License

[Apache 2 License](http://www.apache.org/licenses/LICENSE-2.0)


# Credits

Thanks goes to such GDE's as Jake Wharton and the Google Engineers who produced the examples found at
codelabs:

[CodeLabs](https://www.codelabs.io)

as those examples help me determine and modify some best practices to follow.

![GWS Logo](/art/gws_github_header.png)

[Fred Grott](https://gtihub.com/shareme/MyGithubProfile)

I Believe that diversity of culture combined with launching their lives wins in Android Mobile Application
development. Available for freelancing and other,remotely. Should not your start-up
Launch their Lives?

Only FUNDED start-ups and no recruiters(No recruiters, PLEASE!)

### Repos

[Github](https://github.com/shareme)
[Bitbucket](https://bitbucket.org/fredgrott)

### Social

[G+](https://plus.google.com/u/0/+FredGrott/about)
[Twitter](https://twitter.com/fredgrott)
[Facebook](http://www.facebook.com/fredgrott)
[Reddit](http://www.reddit.com./user/fredgrott/)
[GeekList](https://geekli.st/fredgrott)

### Bookmarks

[Delicious](https://delicious.com/shareme)

### Design

[DeviantArt](http://shareme.deviantart.com)
[BeHance](https://www.behance.net/gwsfredgrott)
[Dribbble](https://dribbble.com/FredGrott)

### StartUps

[AngelList](https://angel.co/fred-grott)
[BuiltINChicago](http://www.builtinchicago.org/member/fred-grott)
[HackerNews](https://news.ycombinator.com/user?id=fredgrott)
[FounderDating](http://members.founderdating.com/profile/6572)

### Freelancing

[GunIO](https://gun.io/accounts/shareme)

### Questions

[StackOverflow](http://stackoverflow.com/users/237740/fred-grott)
[Quora](http://www.quora.com/Fred-Grott)

### CV

[LinkedIN](http://www.linkedin.com/in/shareme/en)
[Xing](https://www.xing.com/profile/Fred_Grott?sc_o=mxb_p)

### Slides

[SlideShare](http://www.slideshare.net/shareme)
[SpeakerDeck](https://speakerdeck.com/fredgrott)

### Articles, Blogging

[Medium](https://medium.com/@fredgrott)
[Blogger blog](http://grottworkshop.blogspot.com)

### Video

[YouTube channel](https://www.youtube.com/channel/UCRQadYlHQ8DKRQ_WwUrfZ_w)
[Ustream](https://www.ustream.tv/manage-show/12940149)


### ProductHunt

[ProductHunt](https://www.producthunt.com/@fredgrott)



# Resources

[Google Android Developer Site](http://developer.android.com)

[Google Android Developer Tool Site](http://tools.android.com)

[Google Android Developer Blog](http://android-developers.blogspot.com/)

[CodeLabs](http://www.codelabs.io)

[StackOverflow Android Questions](http://stackoverflow.com/questions/tagged/android)

[Gradle](http://gradle.org)

[Reddit-androidev](http://reddit.com/r/androdev/)

[AndroidChat at Slack](https://androidchat.slack.com/messages/development/)

[Amazon Android Dev Site](https://developer.amazon.com/public)

[JavaRanch Android Forum](http://www.coderanch.com/forums/f-93/Android)

[Android Development Tools G+ community](https://plus.google.com/communities/114791428968349268860)

[Android Development G+ Community](https://plus.google.com/communities/105153134372062985968)

[Android Developers G+ Community](https://plus.google.com/+AndroidDevelopers/posts)

[Android Design G+ Community](https://plus.google.com/communities/113499773637471211070)

[UX Design for Developers](https://plus.google.com/communities/103651070366324568638)

[Android MVP G+ Community](https://plus.google.com/communities/114285790907815804707)



