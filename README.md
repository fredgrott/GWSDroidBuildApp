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