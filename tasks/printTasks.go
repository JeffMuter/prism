package tasks

import (
	"fmt"
	"prism/util"
)

type PrintableTaskFactory interface {
	CreatePrintable(task Task) util.Printable
}

// types of printables for tasks
type nameTask struct{ Task }
type NameTaskFactory struct{}

func (factory NameTaskFactory) CreatePrintable(task Task) util.Printable {
	return nameTask{Task: task}
}
func (task nameTask) StringToPrint() string {
	return fmt.Sprintf("%s", task.Type)
}

func MakeTasksPrintable(tasks []Task, factory PrintableTaskFactory) []util.Printable {
	var prints []util.Printable
	for _, task := range tasks {
		print := factory.CreatePrintable(task)
		prints = append(prints, print)
	}
	return prints
}
