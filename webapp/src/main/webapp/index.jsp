<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bank Payment Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1a202c 0%, #2d3748 100%);
            color: #e2e8f0;
            margin: 0;
            padding: 40px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            box-sizing: border-box;
        }
        .container {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 480px;
            box-sizing: border-box;
        }
        h1 {
            font-size: 26px;
            color: #63b3ed;
            margin-top: 0;
            margin-bottom: 8px;
            text-align: center;
        }
        p.subtitle {
            font-size: 14px;
            color: #a0aec0;
            text-align: center;
            margin-top: 0;
            margin-bottom: 30px;
        }
        .demo-accounts {
            background: rgba(99, 179, 237, 0.1);
            border-left: 4px solid #63b3ed;
            padding: 12px 15px;
            border-radius: 4px;
            margin-bottom: 25px;
            font-size: 13px;
            color: #cbd5e0;
        }
        .demo-accounts strong {
            color: #63b3ed;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            font-size: 14px;
            color: #cbd5e0;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 12px 16px;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 8px;
            color: white;
            font-size: 15px;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }
        input[type="text"]:focus, input[type="number"]:focus {
            outline: none;
            border-color: #63b3ed;
            background: rgba(255, 255, 255, 0.12);
            box-shadow: 0 0 0 3px rgba(99, 179, 237, 0.2);
        }
        .btn-submit {
            width: 100%;
            background: linear-gradient(90deg, #3182ce 0%, #319795 100%);
            color: white;
            border: none;
            padding: 14px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: opacity 0.3s ease;
            margin-top: 10px;
        }
        .btn-submit:hover {
            opacity: 0.9;
        }
        .footer {
            margin-top: 25px;
            text-align: center;
            font-size: 12px;
            color: #718096;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            padding-top: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Bank Payment Gateway</h1>
        <p class="subtitle">Securely transfer funds between accounts instantly</p>

        <div class="demo-accounts">
            <strong>Active Demo Accounts:</strong><br>
            • ACC1001 (Balance: $5000.00)<br>
            • ACC1002 (Balance: $1500.00)<br>
            • ACC1003 (Balance: $250.00)
        </div>

        <form action="process-payment" method="POST">
            <div class="form-group">
                <label for="fromAccount">From Account Number</label>
                <input type="text" id="fromAccount" name="fromAccount" placeholder="e.g. ACC1001" required>
            </div>

            <div class="form-group">
                <label for="toAccount">To Account Number</label>
                <input type="text" id="toAccount" name="toAccount" placeholder="e.g. ACC1002" required>
            </div>

            <div class="form-group">
                <label for="amount">Transfer Amount ($)</label>
                <input type="number" id="amount" name="amount" step="0.01" min="0.01" placeholder="0.00" required>
            </div>

            <button type="submit" class="btn-submit">Execute Transfer</button>
        </form>

        <div class="footer">
            Secure Banking API Node • Powered by DevOps & Java
        </div>
    </div>
</body>
</html>