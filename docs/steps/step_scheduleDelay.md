# scheduleDelay

Define a point in future until which we should wait. Does not cause waiting. 

| Property | Description |
| ------- | -------- |
| duration | Duration of the delay with appropriate suffix (e.g. `ms` or `s`).  |
| fromLast | Set previous delay point reference as the reference for next delay point; it will be computed as <code>(previous delay point or now) + duration</code>. <br>Note: property does not have any value |
| fromNow | Set this step invocation as the delay point reference; it will be computed as <code>now + duration</code>. <br>Note: property does not have any value |
| key | Key that is referenced later in `awaitDelay` step. If you're introducing the delay through `thinkTime` do not use this property.  |
| max | Upper cap on the duration (if randomized).  |
| min | Lower cap on the duration (if randomized).  |
| negativeExponential | Randomize the duration with negative-exponential distribution, using <code>duration</code> as the mean value. <br>Note: property does not have any value |
| type | Alternative way to set delay reference point. See `fromNow` and `fromLast` property setters. <br>Options:{::nomarkdown}<ul><li><code>FROM_LAST</code></li><li><code>FROM_NOW</code></li></ul>{:/} |

