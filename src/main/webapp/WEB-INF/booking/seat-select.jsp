<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Seats — YatraGo</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .seat-page {
            max-width: var(--container);
            margin: 0 auto;
            padding: 2.5rem 1.5rem 4rem;
        }

        /* ── Back link (reused from results page) ── */
        .results-back {
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--clr-text-muted);
            margin-bottom: 1.5rem;
            transition: color 0.15s;
        }
        .results-back:hover { color: var(--clr-primary); text-decoration: none; }

        /* ── Trip summary bar ── */
        .trip-summary {
            background: var(--clr-surface);
            border: 1px solid var(--clr-border);
            border-radius: var(--radius-lg);
            padding: 1.25rem 1.75rem;
            display: flex;
            align-items: center;
            gap: 2rem;
            flex-wrap: wrap;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-sm);
        }
        .trip-summary-route {
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--clr-text);
            letter-spacing: -0.5px;
            white-space: nowrap;
        }
        .trip-summary-route span { color: var(--clr-primary); }
        .trip-summary-meta {
            display: flex;
            gap: 1.5rem;
            flex-wrap: wrap;
            flex: 1;
        }
        .trip-summary-item {
            font-size: 0.875rem;
            color: var(--clr-text-muted);
        }
        .trip-summary-item strong {
            display: block;
            font-size: 0.6875rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.125rem;
        }

        /* ── Shared card wrapper ── */
        .booking-card {
            background: var(--clr-surface);
            border: 1px solid var(--clr-border);
            border-radius: var(--radius-lg);
            padding: 2rem;
            margin-bottom: 1.5rem;
            box-shadow: var(--shadow-sm);
        }
        .booking-card-title {
            font-size: 1rem;
            font-weight: 700;
            color: var(--clr-text);
            margin-bottom: 1.5rem;
        }

        /* ── Seat legend ── */
        .seat-legend {
            display: flex;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }
        .seat-legend-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.8125rem;
            color: var(--clr-text-muted);
        }
        .seat-legend-swatch {
            width: 22px;
            height: 22px;
            border-radius: var(--radius-sm);
            flex-shrink: 0;
        }
        .swatch-available { background: var(--clr-primary-soft); border: 1.5px solid rgba(14,124,123,0.3); }
        .swatch-selected  { background: #FF6B5B; border: 1.5px solid #E85345; }
        .swatch-taken     { background: var(--clr-border-light); border: 1.5px solid var(--clr-border); }

        /* ── Seat grid ── */
        .seat-grid-wrap { max-width: 340px; }

        .seat-col-headers,
        .seat-row {
            display: grid;
            grid-template-columns: 1fr 1fr 0.6fr 1fr 1fr;
            gap: 8px;
            margin-bottom: 8px;
        }
        .seat-col-header {
            text-align: center;
            font-size: 0.6875rem;
            font-weight: 700;
            color: var(--clr-text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding-bottom: 4px;
        }

        .seat {
            aspect-ratio: 1;
            border-radius: var(--radius-sm);
            border: none;
            cursor: pointer;
            font-size: 0.625rem;
            font-weight: 700;
            transition: transform 0.1s, box-shadow 0.1s;
        }
        .seat:focus-visible { outline: 2px solid var(--clr-primary); outline-offset: 2px; }
        .seat:hover:not(:disabled) { transform: scale(1.1); box-shadow: var(--shadow-md); }
        .seat:active:not(:disabled) { transform: scale(0.95); }

        .seat-available {
            background: var(--clr-primary-soft);
            color: var(--clr-primary);
            border: 1.5px solid rgba(14,124,123,0.3);
        }
        .seat-selected {
            background: #FF6B5B;
            color: #fff;
            border: 1.5px solid #E85345;
        }
        .seat-taken {
            background: var(--clr-border-light);
            color: var(--clr-text-soft);
            border: 1.5px solid var(--clr-border);
            cursor: not-allowed;
        }
        /* aisle column — just an empty spacer, no styles needed */

        .seat-counter {
            margin-top: 1.25rem;
            font-size: 0.9375rem;
            color: var(--clr-text-muted);
            font-weight: 500;
        }
        .seat-counter strong { color: var(--clr-text); }

        /* ── Passenger rows ── */
        .passenger-row {
            display: grid;
            grid-template-columns: 72px 1fr 120px;
            gap: 1rem;
            align-items: start;
            padding-bottom: 1.25rem;
            margin-bottom: 1.25rem;
            border-bottom: 1px solid var(--clr-border-light);
        }
        .passenger-row:last-child { border-bottom: none; margin-bottom: 0; padding-bottom: 0; }

        .passenger-seat-tag {
            font-size: 0.8125rem;
            font-weight: 700;
            color: #FF6B5B;
            background: #FFEDE9;
            border: 1px solid #FCA5A5;
            border-radius: var(--radius-sm);
            padding: 0.5rem 0.375rem;
            text-align: center;
            align-self: center;
        }

        /* ── Confirm row ── */
        .confirm-row {
            display: flex;
            justify-content: flex-end;
        }
        .confirm-btn:disabled {
            opacity: 0.45;
            cursor: not-allowed;
            transform: none !important;
        }

        /* ── Responsive ── */
        @media (max-width: 640px) {
            .trip-summary       { flex-direction: column; align-items: flex-start; gap: 0.875rem; }
            .trip-summary-meta  { gap: 1rem; }
            .passenger-row      { grid-template-columns: 1fr; gap: 0.625rem; }
            .passenger-seat-tag { display: inline-block; text-align: left; }
            .confirm-row        { justify-content: stretch; }
            .confirm-row .btn   { width: 100%; }
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<main>
    <div class="seat-page">

        <a href="javascript:history.back()" class="results-back">&#8592; Back to results</a>

        <%-- Trip summary bar — data set by SeatSelectServlet via ${schedule} attribute --%>
        <div class="trip-summary">
            <div class="trip-summary-route">
                <span>${schedule.routeOrigin}</span>
                &nbsp;&#8594;&nbsp;
                <span>${schedule.routeDestination}</span>
            </div>
            <div class="trip-summary-meta">
                <div class="trip-summary-item">
                    <strong>Date</strong>
                    <fmt:formatDate value="${schedule.journeyDate}" pattern="MMM d, yyyy" />
                </div>
                <div class="trip-summary-item">
                    <strong>Departs</strong>
                    <fmt:formatDate value="${schedule.departureTime}" pattern="hh:mm a" />
                </div>
                <div class="trip-summary-item">
                    <strong>Operator</strong>
                    ${schedule.operatorName}
                </div>
                <div class="trip-summary-item">
                    <strong>Bus</strong>
                    ${schedule.busNumber}
                </div>
                <div class="trip-summary-item">
                    <strong>Fare / seat</strong>
                    NPR <fmt:formatNumber value="${schedule.fare}" maxFractionDigits="0" />
                </div>
            </div>
        </div>

        <form id="bookingForm"
              action="${pageContext.request.contextPath}/confirm-booking"
              method="post">

            <input type="hidden" name="scheduleId" value="${schedule.id}">

            <%-- ── Seat grid ── --%>
            <div class="booking-card">
                <h2 class="booking-card-title">Choose Your Seats</h2>

                <div class="seat-legend">
                    <div class="seat-legend-item">
                        <div class="seat-legend-swatch swatch-available"></div> Available
                    </div>
                    <div class="seat-legend-item">
                        <div class="seat-legend-swatch swatch-selected"></div> Selected
                    </div>
                    <div class="seat-legend-item">
                        <div class="seat-legend-swatch swatch-taken"></div> Taken
                    </div>
                </div>

                <div class="seat-grid-wrap">
                    <div class="seat-col-headers">
                        <div class="seat-col-header">A</div>
                        <div class="seat-col-header">B</div>
                        <div></div><%-- aisle --%>
                        <div class="seat-col-header">C</div>
                        <div class="seat-col-header">D</div>
                    </div>

                    <c:forEach var="row" begin="1" end="10">
                        <div class="seat-row">
                            <button type="button" class="seat seat-available" data-seat="${row}A">${row}A</button>
                            <button type="button" class="seat seat-available" data-seat="${row}B">${row}B</button>
                            <div></div><%-- aisle --%>
                            <button type="button" class="seat seat-available" data-seat="${row}C">${row}C</button>
                            <button type="button" class="seat seat-available" data-seat="${row}D">${row}D</button>
                        </div>
                    </c:forEach>
                </div>

                <p class="seat-counter" id="seat-counter"><strong>0</strong> seat(s) selected</p>
            </div>

            <%-- ── Passenger details ── --%>
            <div class="booking-card" id="passenger-section" style="display:none;">
                <h2 class="booking-card-title">Passenger Details</h2>
                <div id="passenger-rows"></div>
            </div>

            <%-- ── Confirm button ── --%>
            <div class="confirm-row">
                <button type="submit"
                        id="confirm-btn"
                        class="btn btn-primary btn-lg confirm-btn"
                        disabled>
                    Confirm Booking
                </button>
            </div>

        </form>
    </div>
</main>

<footer class="footer">
    <span class="footer-brand">Yatra<span>Go</span></span>
    &copy; 2026 YatraGo. Built for Nepal.
</footer>

<script>
(function () {
    var nav    = document.querySelector('.navbar');
    var toggle = document.getElementById('navToggle');
    var menu   = document.getElementById('mainNav');
    if (nav) {
        window.addEventListener('scroll', function () {
            nav.classList.toggle('scrolled', window.scrollY > 8);
        }, { passive: true });
    }
    if (toggle && menu) {
        toggle.addEventListener('click', function () {
            menu.classList.toggle('nav-open');
        });
    }
}());
</script>

<script>
(function () {
    'use strict';

    /* Seats already booked — populated by SeatSelectServlet.
       Format: array of strings matching data-seat values, e.g. ['1A', '3C']. */
    var takenSeats = ${empty takenSeatsJson ? "[]" : takenSeatsJson};

    var selectedSeats = [];

    /* ── Mark taken seats on load ── */
    takenSeats.forEach(function (seat) {
        var btn = document.querySelector('.seat[data-seat="' + seat + '"]');
        if (btn) { btn.className = 'seat seat-taken'; btn.disabled = true; }
    });

    /* ── Seat click handler ── */
    document.querySelectorAll('.seat').forEach(function (btn) {
        btn.addEventListener('click', function () {
            var seat = this.getAttribute('data-seat');
            var idx  = selectedSeats.indexOf(seat);
            if (idx === -1) {
                selectedSeats.push(seat);
                this.className = 'seat seat-selected';
            } else {
                selectedSeats.splice(idx, 1);
                this.className = 'seat seat-available';
            }
            updateCounter();
            renderPassengerRows();
            updateConfirmButton();
        });
    });

    /* ── Counter ── */
    function updateCounter() {
        document.getElementById('seat-counter').innerHTML =
            '<strong>' + selectedSeats.length + '</strong> seat(s) selected';
    }

    /* ── Passenger rows ── */
    function renderPassengerRows() {
        var section   = document.getElementById('passenger-section');
        var container = document.getElementById('passenger-rows');

        if (selectedSeats.length === 0) {
            section.style.display = 'none';
            return;
        }
        section.style.display = 'block';

        /* Preserve values that the user already typed before the rebuild */
        var saved = {};
        container.querySelectorAll('.passenger-row').forEach(function (row) {
            var s = row.getAttribute('data-seat');
            saved[s] = {
                name: row.querySelector('[name="passengerName"]').value,
                age:  row.querySelector('[name="passengerAge"]').value
            };
        });

        while (container.firstChild) container.removeChild(container.firstChild);

        selectedSeats.forEach(function (seat) {
            container.appendChild(buildRow(seat, saved[seat] || { name: '', age: '' }));
        });

        updateConfirmButton();
    }

    function buildRow(seat, prev) {
        var row = document.createElement('div');
        row.className = 'passenger-row';
        row.setAttribute('data-seat', seat);

        var tag = document.createElement('div');
        tag.className = 'passenger-seat-tag';
        tag.textContent = 'Seat ' + seat;

        var nameGroup = makeInputGroup('Passenger Name', 'text',   'passengerName', 'Full name', null, null, prev.name);
        var ageGroup  = makeInputGroup('Age',             'number', 'passengerAge',  'Age',       '1',  '120', prev.age);

        var hidden = document.createElement('input');
        hidden.type  = 'hidden';
        hidden.name  = 'seatNumber';
        hidden.value = seat;

        row.appendChild(tag);
        row.appendChild(nameGroup);
        row.appendChild(ageGroup);
        row.appendChild(hidden);
        return row;
    }

    function makeInputGroup(labelText, type, name, placeholder, min, max, value) {
        var group = document.createElement('div');
        group.className = 'form-group';
        group.style.marginBottom = '0';

        var lbl = document.createElement('label');
        lbl.className   = 'form-label';
        lbl.textContent = labelText;

        var input = document.createElement('input');
        input.className   = 'form-input';
        input.type        = type;
        input.name        = name;
        input.placeholder = placeholder;
        input.required    = true;
        if (min !== null) input.min = min;
        if (max !== null) input.max = max;
        if (value)        input.value = value;

        group.appendChild(lbl);
        group.appendChild(input);
        return group;
    }

    /* ── Confirm button state ── */
    function updateConfirmButton() {
        var btn = document.getElementById('confirm-btn');
        if (selectedSeats.length === 0) { btn.disabled = true; return; }

        var allValid = true;
        document.querySelectorAll('[name="passengerName"]').forEach(function (el) {
            if (!el.value.trim()) allValid = false;
        });
        document.querySelectorAll('[name="passengerAge"]').forEach(function (el) {
            var v = parseInt(el.value, 10);
            if (!el.value || isNaN(v) || v < 1 || v > 120) allValid = false;
        });
        btn.disabled = !allValid;
    }

    /* Re-check button whenever a passenger field changes */
    document.getElementById('passenger-rows').addEventListener('input', updateConfirmButton);

}());
</script>

<c:if test="${not empty sessionScope.flashMessage}">
    <div id="flash-data" data-type="${sessionScope.flashType}" data-message="${sessionScope.flashMessage}" style="display:none;"></div>
    <c:remove var="flashMessage" scope="session"/>
    <c:remove var="flashType" scope="session"/>
</c:if>
<div id="toast-container"></div>
<script src="${pageContext.request.contextPath}/js/toasts.js"></script>

</body>
</html>
