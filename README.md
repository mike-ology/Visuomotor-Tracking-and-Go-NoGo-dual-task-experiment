# Visuomotor Tracking and Go-NoGo - Dual Task Experiment

## Overview

<p align="center"> <img src="https://github.com/mike-ology/Dual-visual-tracking-and-shape-discrimination-task/blob/master/Stimuli/example.gif"> </p>

**This experiment was programmed in Presentation (version 21.1). A licensed version of Presentation is required to use the program.**
 
The experiment is intended to measure a participants ability to complete two different tasks, separately and together (the dual task condition). The first task requires participants to use the mouse to track a disc that bounces around the screen while the second task requires participants to quickly respond to target shapes presented in the centre of the screen and ignore distractors.

The experiment is adapted closely from the experiment outlined in the following study, which should be referred to for the majority of the technical details:

Bender, A. D., Filmer, H. L., Naughtin, C. K., & Dux, P. E. (2017). **Dynamic, continuous multitasking training leads to task-specific improvements but does not transfer across action selection tasks**. *Npj Science of Learning*, 2(1), 14. https://doi.org/10.1038/s41539-017-0015-4

## Running the Task

The task is broken up into several distinct phases - thresholding, training and testing. Experimenters may wish to run all parts or only select sections depending on their needs. Regardless, the program allows experimenters to choose which section is run when the task is initiated, making it easy to only run the sections required.

### Single-task Thresholding Section - Phase 1

This part runs the two tasks separately, one after another, across multiple trials. Depending on the participants performance, the difficulty of the following trial of that task type will be adjusted with the aim of targeting an 80% performance level. This difficulty level should be used for the following phases so that each participant has a similar level of performance during the single task conditions that the dual task conditions can be compared to later. A logfile is produced that contains the outcome of each trial, and also the final difficulty levels that should be roughly centred on 80% performance for each task for that participant.

On the tracking task, the disc will move slower or faster on the following trial based on the time spent tracking the disc. On the Go-NoGo task, the response window will lengthen or shorten depending on the number of correct responses made. Trial performance that is close to 80% results in small adjustements, while performance that is far from 80% results in larger adjustments. 

Feedback is presented on all trials for both trial types both during and after the trial (i.e. the disc will turn green when it is being successfully tracked, and a green square will flash following a correct response within the response window of the Go-NoGo task.

### Test Section - Phase 1 & 3

This part presents participants with a mix of trials containing both the single task conditions presented during the thresholding, and also adding in the dual task condition, where both tasks must be completed simultaneously. In Phase 1, this section immediately follows the thresholding and uses the final task difficulty levels obtained during that section, and in Phase 3, is run on it's own with the difficult levels requiring manual input when initiating the task.

### Training Section - Phase 2

This section is similar to the Test Section, but differs in that either only single-task trials are presented, or only dual-task trials. The purpose of this section is to allow participants to receive different types of training in order to determine whether one type of training improves performance in the other condition (i.e. does practicing the single-task version of the tasks improve performance on the tasks in the dual-task condition.

Typically, it would be run between Phase 1 and 3, with the two test sessions ascertaining the presence of any training effects. Similar to the test sessions, the difficulty should be set to that level obtained during thresholding, and will require manual input when initiating the task. The type of training (single vs dual) is also selected at this time.

## Customisation

The number of trials run and length of each trial can be adjusted in the parameter box prior to running the experiment within certain limitations to ensure that the program can counterbalance trial-type parameters as necessary. The difficulty can also be adjusted, and is necessary to do so if commencing the study from any other section besides Phase 1.

### Logfile save behaviour

A parameter labelled "Use Local Save" can change the initial save location of logfiles. This task writes logfile data on a trial-by-trial basis so that any unexpected termination will allow the partially collected data to be accessible. Whilst the task can be run from a network location, this occasionally introduces read/write errors that Presentation cannot handle and will terminate the task unexpectedly. 

If this parameter is set to TRUE, Presentation will write logfile data to a 'C:/Presentation Output/Tracking + Shape Dual Task 2019' folder during the scenario. Immediately, prior to the 'Experiment Complete' screen, Presentation will attempt to write a copy of the output to the main logfile where the experiment files are located. Presentation will notify the experimenter if this write operation fails, and should Presentation crash during this operation, an intact logfile will remain in C:/Presentation Output. 

If this parameter is set to FALSE, Presentation will create a logfile in the location of the experiment files as usual, '.../Tracking + Shape Dual Task 2019/Logfiles', regardless of whether this location is on a network or not.
