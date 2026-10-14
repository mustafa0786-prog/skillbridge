<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chat with ${otherUser.name} — SkillBridge</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .chat-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 24px;
        }
        .chat-header {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 16px 24px;
            background: white;
            border-radius: 16px 16px 0 0;
            border: 1px solid #e2e8f0;
            border-bottom: none;
        }
        .chat-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 18px;
        }
        .chat-header-info h3 {
            font-size: 16px;
            font-weight: 700;
            color: #0f172a;
        }
        .chat-header-info p {
            font-size: 13px;
            color: #64748b;
        }
        .chat-back {
            margin-left: auto;
            color: #2563eb;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
        }
        .chat-messages {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-top: none;
            padding: 24px;
            height: 450px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        .chat-bubble {
            max-width: 70%;
            padding: 10px 16px;
            border-radius: 16px;
            font-size: 15px;
            line-height: 1.5;
            word-wrap: break-word;
        }
        .chat-bubble.sent {
            background: #2563eb;
            color: white;
            align-self: flex-end;
            border-bottom-right-radius: 4px;
        }
        .chat-bubble.received {
            background: white;
            color: #1e293b;
            align-self: flex-start;
            border: 1px solid #e2e8f0;
            border-bottom-left-radius: 4px;
        }
        .chat-time {
            font-size: 11px;
            margin-top: 4px;
            opacity: 0.7;
        }
        .chat-empty {
            text-align: center;
            color: #94a3b8;
            padding: 60px 20px;
            font-size: 14px;
        }
        .chat-form {
            display: flex;
            gap: 12px;
            padding: 16px 24px;
            background: white;
            border: 1px solid #e2e8f0;
            border-top: none;
            border-radius: 0 0 16px 16px;
        }
        .chat-form input {
            flex: 1;
            padding: 12px 16px;
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            font-size: 15px;
            font-family: inherit;
            outline: none;
        }
        .chat-form input:focus {
            border-color: #2563eb;
        }
        .chat-form button {
            padding: 12px 24px;
            background: #2563eb;
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
        }
        .chat-form button:hover {
            background: #1d4ed8;
        }
    </style>
</head>
<body>

    <%@ include file="../common/navbar.jsp" %>

    <div class="chat-container">

        <!-- Chat header -->
        <div class="chat-header">
            <div class="chat-avatar">
                ${otherUser.name.substring(0,1).toUpperCase()}
            </div>
            <div class="chat-header-info">
                <h3>${otherUser.name}</h3>
                <p>${otherUser.role}</p>
            </div>
            <a href="/messages" class="chat-back">← Inbox</a>
        </div>

        <!-- Messages -->
        <div class="chat-messages" id="chatMessages">
            <c:choose>
                <c:when test="${empty messages}">
                    <div class="chat-empty">
                        No messages yet. Say hi! 👋
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="m" items="${messages}">
                        <div class="chat-bubble ${m.sender.id == sessionScope.userId ? 'sent' : 'received'}">
                            <div>${m.message}</div>
                            <div class="chat-time">
                                ${m.sentAt.toString().substring(0, 16).replace('T', ' ')}
                                <c:if test="${m.sender.id == sessionScope.userId}">
                                    • ${m.isRead ? '✓✓' : '✓'}
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Send message -->
        <form action="/messages/${otherUser.id}/send" method="post" class="chat-form">
            <input type="text" name="message" placeholder="Type your message..." 
                   required autocomplete="off" maxlength="3000">
            <button type="submit">Send</button>
        </form>

    </div>

    <%@ include file="../common/footer.jsp" %>

    <script>
        const chatMessages = document.getElementById('chatMessages');
        chatMessages.scrollTop = chatMessages.scrollHeight;
    </script>

</body>
</html>