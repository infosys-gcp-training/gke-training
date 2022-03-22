# GKE Training Module
## Activity 07 - Cloud Logging for GKE
### Challenge 1

## Activity Objective
The purpose of this activity is to learn about Cloud Logging.


#### Deploy the first logging challenge
```
$ kubectl apply -f ./challenges/challenge-1.yaml
```

Note the names
#### View challenge-1 pods logs
```
$ kubectl logs challenge-1
```

Note all the logs, this will be very hard to diagnose using the kubectl logs command. \
So we can use the **Logs Explorer** in GCP Cloud Logging.

#### Let’s use Cloud Logging in the Google Cloud Console
Google Cloud Console
1. Go to Logs Explorer
1. For the log query, enter `dog`
> See all the entries? I don’t think we are looking for hot dogs. But there are some warnings.

#### In the Logs Field panel, click _Warning_
What do you see?
> A lot of "hot dog is cold" messages, again, probably not what we are looking for.

#### Click the “X” by _Warning_
This is to stop filtering for warning level messages
1. Click on an entry
1. Click **Expand All**
1. Click on the jsonPayload -> labels -> type value (“food”)
1. Select **Hide Matching Entries**

Notice how we filtered all the “hot dog” related entries?

Note the log query in the query panel. See what has been added?
```
"dog"
-jsonPayload.labels.type="food"
```

> See the “-” at the front? This let’s us filter out logs that match a certain value or property.

Now we can see different log entries

> Looks like we have “dog” and “dog owner” entries.

#### Click on a “dog” entry.
Let’s see what details are there. Click Expand nested fields

In the "labels" field of the jsonPayload we can see the name and the breed fields.

#### Click on a “dog owner” entry.


## Additional Notes
GKE/Kubernetes clusters create a lot of logs. It isn't surprising to see 10s of millions of entries/day. When dealing with a GKE related case, if there is a specific error that the customer wants you to troubleshoot and you see that there are a lot of logs, then try to get them to narrow the timerange of when the error occurred. The more details, the easier it will be to locate the error and other related log entries.
