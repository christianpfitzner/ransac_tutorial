# ransac_tutorial
This is the tutorial for the RANSAC algorithm taught at the Technische Hochschule Ingolstadt, in the course of mobile robotics. 
The script *[generate_data.m](https://github.com/christianpfitzner/ransac_tutorial/blob/master/generate_data.m)* provides a data set, containing a circle and a line pattern, including additional noise. 

![dataset image](https://user-images.githubusercontent.com/20952014/168008036-63e2e9a2-a1a1-4066-9e16-1b80822cbf4e.png)


The principle of the RANSAC is summarized by the following steps: 
1. Select a random subset of the original data. Call this subset the hypothetical inliers.
2. A model is fitted to the set of potential inliers
3. The complete data is then tested against the fitted model. Those points that fit the estimated model well, according to some model-specific loss function, are considered as part of the consensus set.
4. The estimated model is reasonably good if sufficiently many points have been classified as part of the consensus set.
5. Afterwards, the model may be improved by reestimating it using all members of the consensus set, by applying the least square approach. 


<br/><br/>
<br/><br/>
<br/><br/>




## Search for the line model
Use the existing *[template](https://github.com/christianpfitzner/ransac_tutorial/blob/master/ransac_template.m)* to write the RANSAC algorithm to find the line. 

Use the highlighted placeholders to add your code to complete the algorithm. 
```
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        ADD YOUR CODE HERE          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
```
Have a close look in the code and its comments, which provide extra help for the implementation. 

Two points are necessary to calculate the model for a randomly selected set of points. You can use the known equation, but there is a much simpler solution to this. 

![image](https://user-images.githubusercontent.com/20952014/168019489-3a6bc44d-5b4c-45f7-976a-522283d7af2a.png)


Your solution should lead to a similar result like the following figure. 

![image](https://user-images.githubusercontent.com/20952014/168016237-fa93a4ef-4420-44ad-9de5-8a9f4957bba0.png)



<br/><br/>
<br/><br/>
<br/><br/>





## Search for the circle model
If you finished the first task, extend your approach, so the circle is found. 

The equation for a circle is described by the error term in the least square approach via: 
![image](https://user-images.githubusercontent.com/20952014/168009332-a3310db7-bffb-42ca-96fb-fc1b3bcfa6cf.png)

Based on partial derivative the error term can be solved. The result are the following equations, 

$$A = B \cdot u$$

![image](https://user-images.githubusercontent.com/20952014/168009514-f214d678-67e2-4606-84f2-aa02c338567d.png)

which form a linear equation system; here presented as matrices. 

![image](https://user-images.githubusercontent.com/20952014/168009591-0ed4d642-a1d4-43e5-93e8-c9debf1c843d.png)

Finally, the circles radius can be calculated where 

![image](https://user-images.githubusercontent.com/20952014/168009739-f70e4584-0b44-4d00-afed-48a697e5da50.png)




The solution of the RANSAC for the circle should look similar to the following figure. 

![image](https://user-images.githubusercontent.com/20952014/168016643-f82823d4-ace4-419d-91e1-f3fb721592b7.png)



<br/><br/>
<br/><br/>
<br/><br/>


## Helpful links to ease programmin in matlab
* [generate the sum of a vector](https://de.mathworks.com/help/matlab/ref/sum.html)
* [element wise multiplication](https://de.mathworks.com/help/matlab/ref/times.html)
* [common plot commands for line circle and data](https://de.mathworks.com/help/matlab/ref/plot.html)
