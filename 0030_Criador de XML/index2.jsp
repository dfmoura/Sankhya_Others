<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html lang="en">
	<html>
		<head>
		
			    <meta charset="utf-8">
				<meta http-equiv="X-UA-Compatible" content="IE=edge">
				<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
				<title>Card Dashboard</title>
				<style> 
				
					.dashboard {
					  display: flex;
					  justify-content: space-around;
					  align-items: center;
					  height: 100vh;
					}

					.card {
					  width: 200px;
					  height: 200px;
					  background-color: #54dfc3;
					  border-radius: 5px;
					  padding: 20px;
					  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
					}

					h2 {
					  margin-top: 0;
					}

					p {
					  margin-bottom: 0;
					}
				</style>
					<snk:load/>
				
		</head>

		<body>
				<snk:query var="tgfnfe">
					SELECT XML FROM TGFNFE WHERE NUNOTA = :P_NUNOTA
				</snk:query>	
		
		
				<div class="dashboard">
			
					<c:forEach items="${tgfnfe.rows}" var="row">
					<div class="card">
						<h2>Card 1</h2>
						< value="${row.XML}" />
					</div>
					</c:forEach>

				</div>
			</div>
		</body>
	</html>