(function() {
				var app = angular.module('seatallocation',[]);
				app.controller('TabController', function() {
			    this.tab = 1;

			    this.setTab = function(newValue){
			      this.tab = newValue;
			    };

			    this.isSet = function(tabName){
			      return this.tab === tabName;
			    };
			  });

				app.controller("InviteController", function($scope, $http) {
					//Initliase objects
					// $.ajax({
					//     url: "../../Data/Master-Directory-JoSAA.csv",
					//     async: false,
					//     success: function (csvd) {
					//         data = $.csv.toArrays(csvd);
					//     },
					//     dataType: "text",
					//     complete: function () {
					//         // call a function on complete 
					//         inviteList = [];
					//         for (var i = data.length - 1; i >= 0; i--) {
					// 	        var code = data[i][0];
					// 	        var name = data[i][1];
					// 	        var region = data[i][2];

					// 	        inviteList.push({
					// 	            code: code,
					// 	            name: name,
					// 	            region: region
					// 	        });
					//     	}
					// });

					var Url = "http://www.cse.iitb.ac.in/~dibyendu/jeemains/Data/Master-Directory-JoSAA.csv";
					var Data = $http.get(Url).then(function(response){
			            $scope.excelData = response.data;
					    $scope.errorMessage = "";
					    $scope.inviteList = [];
					    var lines, lineNumber, data, length;
					    lines = $scope.excelData.split('\n');
					    lineNumber = 0;
					    for (var i = lines.length - 1; i >= 0; i--) {
					        l = lines[i];

					        lineNumber++;
					        data = l.split(',');

					        var code = data[0];
					        var name = data[1];
					        var region = data[2];

					        $scope.inviteList.push({
					            code: code,
					            name: name,
					            region: region
					        });
					    };
			        });
			        console.log(Data);
			  //       var final_data = $.csv.toArrays(Data);
			  //       var inviteList = [];
			  //       for (var i = final_data.length - 1; i >= 0; i--) {
			  //       	var code = data[i][0];
				 //        var name = data[i][1];
				 //        var region = data[i][2];

				 //        inviteList.push({
				 //            code: code,
				 //            name: name,
				 //            region: region
				 //        });
			  //   	}

				   
					this.college = 1;
				    //this.items = colleges;

				    this.setCollege = function(newValue){
				      this.college = newValue;
				    };

				    this.isSet = function(collegeName){
				      return this.college === collegeName;
				    };
				});
})();