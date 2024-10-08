{{/*
Expand the name of the chart.
*/}}
{{- define "alertflow.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "alertflow.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "alertflow.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "alertflow.labels" -}}
helm.sh/chart: {{ include "alertflow.chart" . }}
{{ include "alertflow.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "alertflow.selectorLabels" -}}
app.kubernetes.io/name: {{ include "alertflow.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Backend Selector labels
*/}}
{{- define "alertflow.backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "alertflow.name" . }}-backend
app.kubernetes.io/instance: {{ .Release.Name }}-backend
{{- end }}

{{/*
Frontend Selector labels
*/}}
{{- define "alertflow.frontend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "alertflow.name" . }}-frontend
app.kubernetes.io/instance: {{ .Release.Name }}-frontend
{{- end }}

{{/*
Postgres Selector labels
*/}}
{{- define "alertflow.postgres.selectorLabels" -}}
app.kubernetes.io/name: {{ include "alertflow.name" . }}-postgres
app.kubernetes.io/instance: {{ .Release.Name }}-postgres
{{- end }}

{{/*
Runners Selector labels
*/}}
{{- define "alertflow.runners.selectorLabels" -}}
app.kubernetes.io/name: {{ include "alertflow.name" . }}-runners
app.kubernetes.io/instance: {{ .Release.Name }}-runners
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "alertflow.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "alertflow.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
