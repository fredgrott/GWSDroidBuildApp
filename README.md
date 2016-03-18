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
to a Robolectric Mocked-JVM TDD way for android application development.

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

# ChangeLog

* March 2016, first alpha release with Jack and Jill toolchain not enabled

# License

[Apache 2 License](http://www.apache.org/licenses/LICENSE-2.0)


# Credits

Thanks goes to such GDE's as Jake Wharton and the Google Engineers who produced the examples found at
codelabs:

[CodeLabs](https://www.codelabs.io)

as those examples help me determine and modify some best practices to follow.

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



